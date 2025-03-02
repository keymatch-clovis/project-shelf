import "package:flutter/foundation.dart";
import "package:oxidized/oxidized.dart";
import "package:project_shelf/providers/database.dart";
import "package:project_shelf/database/database.dart";
import "package:project_shelf/providers/product/product_mementos.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

part "products.g.dart";

const CURRENT_VERSION = 1;

@riverpod
class Products extends _$Products {
  @override
  Future<List<ProductData>> build() async {
    return _find();
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

  Future<void> delete(String uuid) async {
    final database = ref.watch(databaseProvider);

    debugPrint("deleting product: $uuid");
    await database.transaction(() async {
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
