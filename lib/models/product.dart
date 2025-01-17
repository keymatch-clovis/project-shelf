import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

typedef Callback<T> = T Function(Database database);

Future<void> withProductDatabase(Callback<Future<void>> handler) async {
  var database = await openDatabase(
    version: 1,
    join(await getDatabasesPath(), 'database.sqlite'),
    onCreate: (db, version) async {
      await db.execute('''
          create table product (
            id integer primary key,
            name text not null,
            value integer not null,
            stock integer not null,
            code string
          );
        ''');
    },
  );

  var result = await handler(database);
  await database.close();
  return result;
}

class ProductModel extends ChangeNotifier {
  List<Product> products = [];

  Future<void> loadProducts() {
    return withProductDatabase((database) async {
      final List<Map<String, Object?>> map = await database.query('product');
      print(map);

      products = [
        for (final {
              'id': id as int,
              'name': name as String,
              'value': value as int,
              'stock': stock as int,
              'code': code as String?,
            } in map)
          Product(
            id: id,
            name: name,
            value: value,
            code: code,
            stock: stock,
          )
      ];
      notifyListeners();
    });
  }

  Future<void> add(Product product) async {
    return withProductDatabase((database) async {
      await database.insert('product', product.toMap());
      notifyListeners();

      await loadProducts();
    });
  }
}

class Product {
  String name;
  int value;
  int stock;
  int? id;
  String? code;

  Product({
    required this.name,
    required this.value,
    required this.stock,
    this.code,
    this.id,
  });

  static Product empty() {
    return Product(name: "", value: 0, stock: 0);
  }

  Map<String, Object?> toMap() {
    return {
      'name': name,
      'value': value,
      'stock': stock,
      'code': code,
      'id': id,
    };
  }

  @override
  String toString() {
    return 'Product{name: $name, value: $value, code: $code, stock: $stock, id: $id}';
  }
}
