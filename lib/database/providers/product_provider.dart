import 'package:path/path.dart';
import 'package:project_shelf/models/product_model.dart';
import 'package:sqflite/sqflite.dart';

class ProductProvider {
  Database database;

  // Private constructor
  ProductProvider._create({required this.database});

  // Public factory.
  static Future<ProductProvider> create() async {
    var database = await openDatabase(
      version: 1,
      join(await getDatabasesPath(), 'database.sqlite'),
      onCreate: (db, version) async {
        await db.execute('''
          create table product (
            id integer primary key,
            name text,
            value integer,
            code string,
            stock integer
          );
        ''');
      },
    );

    return ProductProvider._create(database: database);
  }

  Future<List<ProductModel>> get() async {
    final List<Map<String, Object?>> map = await database.query('product');

    return [
      for (final {
            'id': id as int,
            'name': name as String,
            'value': value as int,
            'code': code as String,
            'stock': stock as int
          } in map)
        ProductModel(
          id: id,
          name: name,
          value: value,
          code: code,
          stock: stock,
        )
    ];
  }

  Future<ProductModel> insert(CreateProductModel model) async {
    int id = await database.insert('product', model.toMap());

    return ProductModel(
      id: id,
      name: model.name,
      value: model.value,
      code: model.code,
      stock: model.stock,
    );
  }

  Future<int> delete(int id) async {
    return await database.delete(
      'product',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
