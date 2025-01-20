import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:ez_validator/ez_validator.dart';
import 'package:flutter/material.dart';
import 'package:project_shelf/database/database.dart';

class ProductValidator {
  Map<String, dynamic> fields = {
    'name': EzValidator<String>().required().build(),
    'value': EzValidator<String>().required().number().isInt().min(0).build(),
    'stock': EzValidator<String>().required().number().isInt().min(0).build(),
  };
}

class ProductModel extends ChangeNotifier {
  final AppDatabase _database;

  List<ProductData> products = [];

  ProductModel(this._database);

  Future<void> loadProducts() async {
    products = await _database.products;
    print(products);

    notifyListeners();
  }

  Future<List<ProductData>> search(String query) async {
    _database.search(query);
    return [];
  }

  Future<void> add({
    required String name,
    required int value,
    required int stock,
    String? code,
  }) async {
    debugPrint('Adding new product');
    await _database.addProduct(
      ProductCompanion.insert(name: name, value: value, stock: stock),
    );

    notifyListeners();
    await loadProducts();
  }
}
