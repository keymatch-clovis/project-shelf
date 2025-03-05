import 'package:drift/drift.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'package:oxidized/oxidized.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/lib/cop_currency.dart';
import 'package:project_shelf/lib/error.dart';
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

  Future<void> create({
    required InvoiceCompanion data,
    required List<InvoiceProduct> invoiceProducts,
  }) async {
    final database = ref.watch(databaseProvider);

    await database.transaction(() async {
      debugPrint("Creating invoice with data: $data");
      final invoice =
          await database.into(database.invoice).insertReturning(data);
      debugPrint("Invoice created: $invoice");

      debugPrint("Adding products: $invoiceProducts to invoice: $invoice");
      for (final invoiceProduct in invoiceProducts) {
        debugPrint("Removing stock from product");
        await ref.read(productsProvider.notifier).removeFromStock(
              product: invoiceProduct.product,
              count: invoiceProduct.count,
            );

        debugPrint("Adding: $invoiceProduct");
        final productInvoice = await database
            .into(database.productInvoice)
            .insertReturning(ProductInvoiceCompanion.insert(
              price: Value(invoiceProduct.price.realValue),
              discount: Value(invoiceProduct.discount.realValue),
              count: invoiceProduct.count,
              productUuid: invoiceProduct.product.uuid,
              invoiceUuid: invoice.uuid,
            ));
        debugPrint("$productInvoice added to $invoice");
      }
    });

    await _invalidate();
  }

  Future<ProductInvoiceData> addProduct(ProductInvoiceCompanion data) async {
    final database = ref.watch(databaseProvider);

    debugPrint("Adding product to invoice: $data");
    final productInvoice =
        await database.into(database.productInvoice).insertReturning(data);
    debugPrint("Product added to invoice: $productInvoice");

    await _invalidate();
    return productInvoice;
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

  Future<Result<Unit, CustomError>> printInvoice({
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
      return p[PreferenceName.COMPANY_NAME]!;
    }).then(removeDiacritics);
    final companyDocument =
        await ref.read(preferencesProvider.future).then((p) {
      return p[PreferenceName.COMPANY_DOCUMENT]!;
    }).then(removeDiacritics);
    final companyEmail = await ref.read(preferencesProvider.future).then((p) {
      return p[PreferenceName.COMPANY_EMAIL]!;
    }).then(removeDiacritics);
    final companyPhone = await ref.read(preferencesProvider.future).then((p) {
      return p[PreferenceName.COMPANY_PHONE]!;
    });

    final paired = await PrintBluetoothThermal.connect(
      macPrinterAddress: printerMac,
    );

    if (!paired) {
      return Err(CustomError.COULD_NOT_CONNECT_TO_PRINTER_ERROR);
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
        companyName,
        styles: PosStyles(bold: true, align: PosAlign.center),
      );
      bytes += generator.text(
        "NIT: $companyDocument, Regimen Simple",
      );
      bytes += generator.text(
        "TELEFONO: $companyPhone",
      );
      bytes += generator.text(
        "EMAIL: $companyEmail",
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
