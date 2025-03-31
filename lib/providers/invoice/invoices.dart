import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:drift/drift.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:image/image.dart';
import 'package:intl/intl.dart';
import 'package:oxidized/oxidized.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/lib/cop_currency.dart';
import 'package:project_shelf/data/error.dart';
import 'package:project_shelf/lib/util.dart';
import 'package:project_shelf/providers/cities.dart';
import 'package:project_shelf/providers/customers.dart';
import 'package:project_shelf/providers/database.dart';
import 'package:project_shelf/providers/preferences.dart';
import 'package:project_shelf/providers/product/products.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "invoices.g.dart";

const CURRENT_VERSION = 1;

class InvoiceProduct {
  ProductData product;
  CopCurrency price;
  CopCurrency discount;
  int count;

  InvoiceProduct.fromProduct(this.product)
      : this.price = CopCurrency.fromCents(product.price),
        this.discount = CopCurrency.zero(),
        this.count = 0;

  InvoiceProduct({
    required this.product,
    String? price,
    String? discount,
    int? count,
  })  : this.price = CopCurrency.fromString(price),
        this.discount = CopCurrency.fromString(discount),
        this.count = count ?? 0;
}

class ProductInvoiceWithProduct {
  final ProductInvoiceData productInvoice;
  final ProductData product;

  ProductInvoiceWithProduct(
      {required this.productInvoice, required this.product});
}

class InvoiceWithProducts {
  final InvoiceData invoice;
  final List<ProductInvoiceWithProduct> products;

  InvoiceWithProducts({required this.invoice, required this.products});
}

class InvoiceWithData {
  final InvoiceData invoice;
  final CustomerData customer;

  InvoiceWithData({required this.invoice, required this.customer});
}

final invoicesWithDataProvider =
    FutureProvider.autoDispose<List<InvoiceWithData>>((ref) {
  ref.watch(invoicesProvider);
  final database = ref.watch(databaseProvider);
  final query = (database.select(database.invoice)).join([
    innerJoin(database.customer,
        database.customer.uuid.equalsExp(database.invoice.customerUuid)),
  ])
    ..orderBy([OrderingTerm.desc(database.invoice.number)]);

  return query.map((rows) {
    return InvoiceWithData(
      invoice: rows.readTable(database.invoice),
      customer: rows.readTable(database.customer),
    );
  }).get();
});

@riverpod
class Invoices extends _$Invoices {
  @override
  Future<List<InvoiceData>> build() async {
    return _find();
  }

  Future<Result<Unit, Error>> _delete(String uuid) async {
    final database = ref.watch(databaseProvider);

    debugPrint("Deleting $uuid");
    return await Result.asyncOf(() async {
      return await database.transaction(() async {
        debugPrint("Removing products from invoice.");
        await (database.delete(database.productInvoice)
              ..where((pi) => pi.invoiceUuid.equals(uuid)))
            .go();

        debugPrint("Removing invoice.");
        await (database.delete(database.invoice)
              ..where((i) => i.uuid.equals(uuid)))
            .go();

        debugPrint("Invoice deleted.");
        return Unit.unit;
      });
    });
  }

  Future<Result<Unit, FileLoadError>> uploadInvoices() async {
    final file = await FilePicker.platform
        .pickFiles(
          dialogTitle: "Seleccionar archivo de datos",
          allowMultiple: false,
          withData: true,
        )
        .then((r) => Option.from(r));

    if (file.isNone()) {
      return Err(FileLoadError.FILE_NOT_SELECTED);
    }

    final data = Result.of(() {
      final decoded = utf8.decode(file.unwrap().files.single.bytes!);
      return const CsvToListConverter()
          .convert(decoded, shouldParseNumbers: false);
    });

    if (data.isErr()) {
      debugPrint(data.unwrapErr().toString());
      return Err(FileLoadError.BROKEN_FILE);
    }

    final rows = data.unwrap();
    final database = ref.watch(databaseProvider);

    return await Result.asyncOf(() async {
      return await database.transaction(() async {
        final invoiceUuids =
            rows.map((rows) => rows[1] as String).toSet().toList();

        // Get ALL products, to search them for their names.
        final products = await ref.read(productsProvider.future);

        // Get ALL clients, to search them for their names, and business names.
        final customers = await ref.read(customersProvider.future);

        for (final uuid in invoiceUuids) {
          final invoiceNumber = rows.firstWhere((rows) => rows[1] == uuid)[0];

          // Search for invoice number. If present, remove it. This is for this
          // data is always the same, and we should be able to upload it without
          // damaging the already added data.
          await (database.select(database.invoice)
                ..where((i) => i.number.equals(int.parse(invoiceNumber))))
              .getSingleOrNull()
              .then((i) {
            if (i != null) {
              _delete(i.uuid);
            }
          });

          final invoiceDate = rows.firstWhere((rows) => rows[1] == uuid)[2];
          final invoiceProducts = rows.where((rows) => rows[1] == uuid);
          final invoiceCustomer = rows.firstWhere((rows) => rows[1] == uuid)[8];

          final extractedCustomerByName = extractOne(
            query: invoiceCustomer,
            choices: customers,
            getter: (customer) => customer.customer.name,
          );
          final extractedCustomerByBusinessName = extractOne(
            query: invoiceCustomer,
            choices: customers,
            getter: (customer) => customer.customer.businessName ?? "",
          );

          // Default customer UUID.
          var foundCustomer = "2eafc5f4-2507-43c5-ba97-f698c34957cb";
          if (extractedCustomerByBusinessName.score > 70) {
            foundCustomer =
                extractedCustomerByBusinessName.choice.customer.uuid;
          }
          if (extractedCustomerByName.score > 70) {
            foundCustomer = extractedCustomerByName.choice.customer.uuid;
          }

          debugPrint("Creating invoice: $uuid");
          final invoice = await database
              .into(database.invoice)
              .insertReturning(InvoiceCompanion.insert(
                number: int.parse(invoiceNumber),
                date: Value(DateFormat("d/MM/yyyy")
                    .parse(invoiceDate)
                    // Remove a whole year, the data is broken.
                    .subtract(const Duration(days: 365))),
                customerUuid: foundCustomer,
              ));
          debugPrint("Invoice created: $invoice");

          for (final productRow in invoiceProducts) {
            // Search for the product that has the most similar name.
            final extracted = extractOne(
              query: productRow[3],
              choices: products,
              getter: (product) => product.name,
            );

            var foundProduct = extracted.choice;
            // If the product name is not as equal, we create a new one.
            if (extracted.score < 90) {
              debugPrint("Creating product with name: ${productRow[3]}");
              foundProduct = await (database
                  .into(database.product)
                  .insertReturning(ProductCompanion.insert(
                    name: productRow[3],
                  )));
              debugPrint("Product created: $foundProduct");
            }

            final productCount = int.parse(productRow[4]);
            final productPrice =
                BigInt.from(int.parse(productRow[5]) / productCount) *
                    BigInt.from(100);
            debugPrint("Loaded, count: $productCount, value: $productPrice");

            // If the product is already in the invoice, update the value.
            final productInvoice =
                await (database.select(database.productInvoice)
                      ..where((pi) => Expression.and([
                            pi.productUuid.equals(foundProduct.uuid),
                            pi.invoiceUuid.equals(invoice.uuid),
                          ])))
                    .getSingleOrNull();

            if (productInvoice != null) {
              debugPrint("Updating: $productInvoice");
              await database
                  .update(database.productInvoice)
                  .replace(productInvoice.copyWith(
                    count: productInvoice.count + productCount,
                  ));
            } else {
              debugPrint("Adding: $foundProduct");
              final productInvoice = await database
                  .into(database.productInvoice)
                  .insertReturning(ProductInvoiceCompanion.insert(
                    price: Value(productPrice),
                    discount: productRow[6].toString().trim().isEmpty
                        ? Value.absent()
                        : Value(BigInt.parse(productRow[6]) * BigInt.from(100)),
                    count: productCount,
                    productUuid: foundProduct.uuid,
                    invoiceUuid: invoice.uuid,
                  ));
              debugPrint("$productInvoice added to $invoice");
            }
          }
          debugPrint("Invoice loaded");
        }

        debugPrint("Invoices loaded");
        // Invalidate the state once all the products have loaded.
        await _invalidate();
        return Unit.unit;
      });
    }).mapErr((err) {
      debugPrint(err.toString());
      return FileLoadError.INCORRECT_FILE_FORMAT;
    });
  }

  Future<Option<InvoiceWithProducts>> findByUuid(String invoiceUuid) async {
    final database = ref.watch(databaseProvider);

    final invoice = await (database.select(database.invoice)
          ..where((i) => i.uuid.equals(invoiceUuid)))
        .getSingleOrNull()
        .then((i) => Option.from(i));

    if (invoice.isNone()) {
      return Option.none();
    }

    final query = database.select(database.invoice).join([
      innerJoin(database.productInvoice,
          database.productInvoice.invoiceUuid.equalsExp(database.invoice.uuid)),
      innerJoin(database.product,
          database.productInvoice.productUuid.equalsExp(database.product.uuid)),
    ])
      ..where(database.invoice.uuid.equals(invoiceUuid));

    final products = await query
        .map(
          (rows) => ProductInvoiceWithProduct(
            productInvoice: rows.readTable(database.productInvoice),
            product: rows.readTable(database.product),
          ),
        )
        .get();

    return Option.some(InvoiceWithProducts(
      invoice: invoice.unwrap(),
      products: products,
    ));
  }

  Future<int> getConsecutive() async {
    final database = ref.watch(databaseProvider);

    return (database.select(database.invoice)
          ..orderBy([
            (i) => OrderingTerm.desc(i.number),
          ])
          ..limit(1))
        .getSingleOrNull()
        // Wrap in an option, and return the next consecutive or 1.
        .then((i) => Option.from(i))
        .then((i) => i.isSome() ? i.unwrap().number + 1 : 1);
  }

  Future<Result<Unit, PrintError>> printInvoice({
    required InvoiceData invoice,
    required String printerMac,
  }) async {
    final invoiceWithProducts =
        await this.findByUuid(invoice.uuid).then((i) => i.unwrap());
    final customer = await ref
        .read(customersProvider.notifier)
        .findByUuid(invoice.customerUuid)
        .then((c) => c.unwrap());
    final city = await ref
        .read(citiesProvider.notifier)
        .findByRowId(customer.cityRowId)
        .then((c) => c.unwrap());

    final companyName = await ref.read(preferencesProvider.future).then((p) {
      return Result.of(() => p[PreferenceName.COMPANY_NAME]!);
    }).then((result) => result.map(removeDiacritics));
    if (companyName.isErr()) {
      return Err(PrintError.NO_COMPANY_NAME);
    }

    final companyDocument =
        await ref.read(preferencesProvider.future).then((p) {
      return Result.of(() => p[PreferenceName.COMPANY_DOCUMENT]!);
    }).then((result) => result.map(removeDiacritics));
    if (companyDocument.isErr()) {
      return Err(PrintError.NO_COMPANY_DOCUMENT);
    }

    final companyEmail = await ref.read(preferencesProvider.future).then((p) {
      return Result.of(() => p[PreferenceName.COMPANY_EMAIL]!);
    }).then((result) => result.map(removeDiacritics));
    if (companyEmail.isErr()) {
      return Err(PrintError.NO_COMPANY_EMAIL);
    }

    final companyPhone = await ref.read(preferencesProvider.future).then((p) {
      return Result.of(() => p[PreferenceName.COMPANY_PHONE]!);
    }).then((result) => result.map(removeDiacritics));
    if (companyPhone.isErr()) {
      return Err(PrintError.NO_COMPANY_PHONE);
    }

    final paired = await PrintBluetoothThermal.connect(
      macPrinterAddress: printerMac,
    );
    if (!paired) {
      return Err(PrintError.COULD_NOT_CONNECT_TO_PRINTER);
    }

    try {
      List<int> bytes = [];
      final profile = await CapabilityProfile.load();
      final generator = Generator(PaperSize.mm58, profile);

      final logoBytes =
          (await rootBundle.load('assets/logo.jpeg')).buffer.asUint8List();
      final logo = await (Command()
            ..decodeImage(logoBytes)
            ..copyResize(width: 200)
            ..grayscale(amount: 20))
          .getImage();

      bytes += generator.image(logo!);
      bytes += generator.text(
        companyName.unwrap(),
        styles: PosStyles(bold: true, align: PosAlign.center),
      );
      bytes += generator.text(
        "NIT: ${companyDocument.unwrap()}, Regimen Simple",
      );
      bytes += generator.text(
        "TELEFONO: ${companyPhone.unwrap()}",
      );
      bytes += generator.text(
        "EMAIL: ${companyEmail.unwrap()}",
      );

      bytes += generator.feed(1);

      bytes += generator.text(
        removeDiacritics("CLIENTE: ${removeDiacritics(customer.name)}"),
      );
      bytes += generator.text(
        removeDiacritics("MUNICIPIO: ${removeDiacritics(city.city)}"),
      );

      bytes += generator.text("FECHA: ${invoice.date}");

      bytes += generator.feed(1);

      bytes += generator.row([
        PosColumn(
          text: "U.",
          width: 2,
        ),
        PosColumn(
          text: "PRODUCTO",
          styles: PosStyles(align: PosAlign.center),
          width: 5,
        ),
        PosColumn(
          text: "VALOR",
          styles: PosStyles(align: PosAlign.center),
          width: 5,
        ),
      ]);

      BigInt totalInvoice = BigInt.from(0);
      for (final item in invoiceWithProducts.products) {
        final totalPrice = (item.productInvoice.price *
                BigInt.from(item.productInvoice.count)) -
            item.productInvoice.discount;

        totalInvoice += totalPrice;

        bytes += generator.row([
          PosColumn(
            text: item.productInvoice.count.toString(),
            width: 2,
          ),
          PosColumn(
            text: removeDiacritics(item.product.name),
            width: 5,
          ),
          PosColumn(
            text: CopCurrency.fromCents(totalPrice).formattedValue,
            styles: PosStyles(align: PosAlign.right),
            width: 5,
          ),
        ]);
      }

      bytes += generator.feed(1);

      bytes += generator.text(
        "TOTAL",
        styles: PosStyles(bold: true, align: PosAlign.right),
      );
      bytes += generator.text(
        CopCurrency.fromCents(totalInvoice).formattedValue,
        styles: PosStyles(align: PosAlign.right),
      );

      bytes += generator.feed(4);
      await PrintBluetoothThermal.writeBytes(bytes);
    } finally {
      await PrintBluetoothThermal.disconnect;
    }
    return Ok.unit();
  }

  Future<List<InvoiceData>> _find() async {
    final database = ref.watch(databaseProvider);
    return (database.select(database.invoice)
          ..orderBy([(i) => OrderingTerm.desc(i.number)]))
        .get();
  }

  Future<void> _invalidate() async {
    // This will cause "build" on our notifier to asynchronously be called again,
    // and will notify listeners when doing so.
    ref.invalidateSelf();

    // (Optional) We can then wait for the new state to be computed.
    // This ensures "addTodo" does not complete until the new state is available.
    await future;
  }
}
