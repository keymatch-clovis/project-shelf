import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/shared/data_access/sqlite_data_access.dart';
import 'package:project_shelf/shared/domain/entity/product.dart';
import 'package:project_shelf/shared/gateway/product_gateway.dart';
import 'package:uuid/uuid.dart';

class SqliteProductDataAccess implements ProductGateway {
  final SqliteDataAccess _dataAccess;

  SqliteProductDataAccess(this._dataAccess);

  @override
  Future<Product> create({
    required String name,
    required int price,
    required int stock,
  }) async {
    print("Inserting Product: $name, $price, $stock");

    // We have to create the UUID, and then search the newly created product
    // in the database.
    final uuid = Uuid().v4();
    await _dataAccess.db.rawInsert("""
            INSERT INTO product (uuid, name, price, stock)
            VALUES (?, ?, ?, ?);
        """, [uuid, name, price, stock]);

    return _dataAccess.db
        .query("product",
            columns: ["uuid", "name", "price", "stock"],
            where: "uuid = ?",
            whereArgs: [uuid])
        .then((res) => res.first)
        .then(Product.fromMap);
  }

  @override
  Future<List<Product>> find() {
    return _dataAccess.db.query(
      "product",
      columns: ["uuid", "name", "price", "stock"],
    ).then((res) => res.map(Product.fromMap).toList());
  }

  @override
  Future<Unit> deleteByUuid(String uuid) {
    // TODO: implement deleteByUuid
    throw UnimplementedError();
  }

  @override
  Future<Product> findByUuid(String uuid) {
    // TODO: implement findByUuid
    throw UnimplementedError();
  }

  @override
  Future<Product> update(String uuid) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAll() {
    print("Deleting all products");
    return _dataAccess.db.delete("product");
  }
}
