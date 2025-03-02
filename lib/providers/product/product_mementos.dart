import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/providers/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:oxidized/oxidized.dart';

part 'product_mementos.g.dart';

const CURRENT_VERSION = 1;

class ProductSerializer extends ValueSerializer {
  @override
  T fromJson<T>(json) {
    return ProductData.fromJson(json) as T;
  }

  @override
  toJson<T>(T value) {
    if (value is BigInt) {
      return value.toString();
    }
    return value;
  }
}

class ProductMementosState {
  final String productUuid;
  final List<ProductMementoData> mementos;

  const ProductMementosState({
    required this.productUuid,
    required this.mementos,
  });
}

@riverpod
class ProductMementos extends _$ProductMementos {
  @override
  Future<ProductMementosState> build(String productUuid) async {
    return ProductMementosState(
      productUuid: productUuid,
      mementos: await _find(productUuid),
    );
  }

  Future<void> create(ProductData data) async {
    final database = ref.watch(databaseProvider);
    final productUuid = await future.then((s) => s.productUuid);

    debugPrint("Creating memento: $data");
    final memento = await (database
        .into(database.productMemento)
        .insertReturning(ProductMementoCompanion.insert(
          data: jsonEncode(data.toJson(serializer: ProductSerializer())),
          version: CURRENT_VERSION,
          productUuid: productUuid,
        )));
    debugPrint("Memento created: $memento");

    await _invalidate();
  }

  Future<void> deleteAll() async {
    final database = ref.watch(databaseProvider);
    final productUuid = await future.then((s) => s.productUuid);

    debugPrint("deleting mementos from product: $productUuid");
    final mementos = await (database.delete(database.productMemento)
          ..where((pm) => pm.productUuid.equals(productUuid)))
        .goAndReturn();
    debugPrint("mementos deleted: $mementos");

    await _invalidate();
  }

  Future<Option<ProductMementoData>> findByUuid(String uuid) async {
    final database = ref.watch(databaseProvider);
    return (database.select(database.productMemento)
          ..where((pm) => pm.uuid.equals(uuid)))
        .getSingleOrNull()
        .then((pm) => Option.from(pm));
  }

  Future<List<ProductMementoData>> _find(String productUuid) async {
    final database = ref.watch(databaseProvider);
    return (database.select(database.productMemento)
          ..where((pm) => pm.productUuid.equals(productUuid)))
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
