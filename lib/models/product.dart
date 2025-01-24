import 'package:ez_validator/ez_validator.dart';
import 'package:flutter/material.dart';
import 'package:project_shelf/database/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product.g.dart';

class ProductValidator {
  Map<String, dynamic> fields = {
    'name': EzValidator<String>().required().build(),
    'value': EzValidator<String>().required().number().isInt().min(0).build(),
    'stock': EzValidator<String>().required().number().isInt().min(0).build(),
  };
}

@riverpod
class ProductModel extends _$ProductModel {
  @override
  FutureOr<List<ProductData>> build() {
    return ref.watch(databaseProvider).getProducts();
  }

  Future<void> add({
    required String name,
    required int value,
    required int stock,
    String? code,
  }) async {
    debugPrint('Adding new product');
    await ref.watch(databaseProvider).addProduct(
      ProductCompanion.insert(name: name, value: value, stock: stock),
    );

    // Once the creation is done, we mark the local cache as dirty. This will
    // cause "build" to be asynchronously be called again.
    ref.invalidateSelf();
    // (Optional) Wait for the new state to be computed.
    // await future;
  }
}
