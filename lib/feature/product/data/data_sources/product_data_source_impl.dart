import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/feature/product/data/data_sources/product_data_source.dart';

class ProductDataSourceImpl implements ProductDataSource {
  final ShelfDatabase _database;

  ProductDataSourceImpl(this._database);

  @override
  Future<Result<String, Error>> create(ProductData data) {
    return Result.asyncOf(() => _database
        .insertProduct(
          data.uuid,
          data.name,
          data.price,
          data.stock,
        )
        .then((result) => result.first));
  }

  @override
  Future<Result<Unit, Error>> delete(String uuid) {
    return Result.asyncOf(() {
      return _database.deleteProduct(uuid).then((_) => Unit.unit);
    });
  }

  @override
  Result<Stream<List<ProductData>>, Error> find() {
    return Result.of(_database.getProducts().watch);
  }

  @override
  Future<Result<ProductData, Error>> findByUuid(String uuid) {
    return Result.asyncOf(() {
      return _database.getProductByUuid(uuid).getSingle();
    });
  }

  @override
  Future<Result<Unit, Error>> update(ProductData data) {
    return Result.asyncOf(() {
      return _database
          .updateProduct(
            data.name,
            data.price,
            data.stock,
            data.uuid,
          )
          .then((_) => Unit.unit);
    });
  }
}
