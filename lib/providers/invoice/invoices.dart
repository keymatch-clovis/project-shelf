import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/lib/cop_currency.dart';
import 'package:project_shelf/providers/database.dart';
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

  Future<List<InvoiceData>> _find() async {
    final database = ref.watch(databaseProvider);
    return database.select(database.invoice).get();
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
