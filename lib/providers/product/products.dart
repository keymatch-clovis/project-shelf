import "dart:convert";

import "package:csv/csv.dart";
import "package:drift/drift.dart";
import "package:file_picker/file_picker.dart";
import "package:flutter/foundation.dart";
import "package:intl/intl.dart";
import "package:oxidized/oxidized.dart";
import "package:project_shelf/lib/error.dart";
import "package:project_shelf/providers/database.dart";
import "package:project_shelf/database/database.dart";
import "package:project_shelf/providers/product/product_mementos.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

part "products.g.dart";

const CURRENT_VERSION = 1;

class Product {
  ProductData data;

  Product(this.data);

  String get formattedValue => NumberFormat.currency(
        symbol: "",
        decimalDigits: 0,
      ).format(data.price / BigInt.from(100));

  String get formattedStock =>
      data.stock > 9999 ? "9999" : data.stock.toString();
}

extension AsProduct on ProductData {
  Product asProduct() => Product(this);
}

@riverpod
class Products extends _$Products {
  @override
  Future<List<ProductData>> build() async {
    return _find();
  }

  Future<Result<Unit, FileLoadError>> uploadProducts() async {
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
      for (final row in rows) {
        debugPrint("creating product: $row");
        await database.into(database.product).insert(
              ProductCompanion.insert(
                uuid: Value(row[0]),
                name: row[1],
                price: Value(BigInt.parse(row[2])),
                stock: Value(int.parse(row[3])),
              ),
            );
      }
      debugPrint("Products loaded");

      // Invalidate the state once all the products have loaded.
      await _invalidate();

      return Unit.unit;
    }).mapErr((err) {
      debugPrint(err.toString());
      return FileLoadError.INCORRECT_FILE_FORMAT;
    });
  }

  Future<ProductData> create(ProductCompanion data) async {
    final database = ref.watch(databaseProvider);

    debugPrint("creating product: $data");
    final product =
        await (database.into(database.product).insertReturning(data));
    debugPrint("product created: $product");

    await _invalidate();
    return product;
  }

  Future<void> replace(ProductData data) async {
    final database = ref.watch(databaseProvider);

    // We are making a memento, and updating the product.
    await database.transaction(() async {
      final old = await findByUuid(data.uuid).unwrap();

      // See more: https://refactoring.guru/design-patterns/memento
      await ref.read(productMementosProvider(data.uuid).notifier).create(old);

      debugPrint("updating product with: $data");
      await database.update(database.product).replace(data);
      debugPrint("product updated");

      await _invalidate();
    });
  }

  Future<Result<Unit, ProductError>> delete(String uuid) async {
    final database = ref.watch(databaseProvider);

    debugPrint("deleting product: $uuid");
    return await Result.asyncOf(() async {
      await database.transaction(() async {
        // Check if the product is associated with any invoice.
        await (database.select(database.productInvoice)
              ..where((pi) => pi.productUuid.equals(uuid)))
            .get()
            .then((list) => {
                  if (list.isNotEmpty)
                    throw ProductError.PRODUCT_IS_REFERENCED_IN_INVOICES,
                });

        // Remove product mementos.
        await ref.watch(productMementosProvider(uuid).notifier).deleteAll();

        // Remove product.
        return await (database.delete(database.product)
              ..where((p) => p.uuid.equals(uuid)))
            .goAndReturn()
            .then((products) => products.first);
      });
      debugPrint("product deleted: $uuid");
      await _invalidate();
      return Unit.unit;
    });
  }

  Future<void> removeFromStock({
    required ProductData product,
    required int count,
  }) async {
    final database = ref.watch(databaseProvider);

    // We are making a memento, and updating the product.
    await database.transaction(() async {
      final old = await findByUuid(product.uuid).unwrap();

      // See more: https://refactoring.guru/design-patterns/memento
      await ref
          .read(productMementosProvider(product.uuid).notifier)
          .create(old);

      debugPrint("removing: $count, from: $product");
      await database.update(database.product).replace(product.copyWith(
            stock: product.stock - count,
          ));
      debugPrint("product updated");

      await _invalidate();
    });
  }

  Future<Option<ProductData>> findByUuid(String uuid) {
    final database = ref.watch(databaseProvider);
    return (database.select(database.product)
          ..where((p) => p.uuid.equals(uuid)))
        .getSingleOrNull()
        .then((p) => Option.from(p));
  }

  Future<List<ProductData>> _find() {
    final database = ref.watch(databaseProvider);
    return database.select(database.product).get();
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
