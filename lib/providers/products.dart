import 'package:flutter/material.dart';
import 'package:project_shelf/database/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products.g.dart';

@riverpod
class Products extends _$Products {
  @override
  FutureOr<List<ProductData>> build() {
    return ref.watch(databaseProvider).getProducts();
  }

  Future<void> add(Map<String, String> data) async {
    debugPrint('Adding new product');
    debugPrint('$data');
    await ref.watch(databaseProvider).addProduct(data);

    // Once the creation is done, we mark the local cache as dirty. This will
    // cause "build" to be asynchronously be called again.
    ref.invalidateSelf();
    // (Optional) Wait for the new state to be computed.
    await future;
  }
}
