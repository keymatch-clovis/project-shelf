import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:project_shelf/database/database.dart';

class ProductModel extends ChangeNotifier {
  List<ProductData> products = [];
  AppDatabase database;

  ProductModel(this.database);

  Future<void> loadProducts() async {
    products = await database.products;
    print(products);

    notifyListeners();
  }

  Future<List<ProductData>> search(String query) async {
    database.search(query);
    return [];
  }

  Future<void> add(Map<String, String?> product) async {
    print(product);
    await database.addProduct(
      ProductCompanion(
          name: Value(product['name']!),
          value: Value(int.parse(product['value']!)),
          stock: Value(int.parse(product['stock']!)),
          code: Value(product['code'])),
    );

    notifyListeners();

    await loadProducts();
  }
}
