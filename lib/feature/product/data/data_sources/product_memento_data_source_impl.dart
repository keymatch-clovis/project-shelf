import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/feature/product/data/data_sources/product_memento_data_source.dart';

class ProductMementoDataSourceImpl implements ProductMementoDataSource {
  final ShelfDatabase _database;

  ProductMementoDataSourceImpl(this._database);

  @override
  Result<Stream<List<ProductMementoData>>, Error> find(String customerUuid) {
    return Result.of(_database.getProductMementos(customerUuid).watch);
  }

  @override
  Future<Result<String, Error>> create(ProductMementoData data) {
    return Result.asyncOf(() => _database
        .insertProductMemento(
          data.uuid,
          data.date,
          data.data,
          data.version,
          data.product,
        )
        .then((result) => result.first));
  }
}
