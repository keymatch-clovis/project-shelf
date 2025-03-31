import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/database/database.dart';

// In Clean Architecture, we define the models with the data we want to use.
// As this data comes directly from our database, we can use the Drift created
// classes, and try to optimize the code.

// NOTE: I think this class is very closely related to the repository class in
// the domain layer.
abstract class ProductDataSource {
  Result<Stream<List<ProductData>>, Error> find();
  Future<Result<ProductData, Error>> findByUuid(String uuid);
  Future<Result<String, Error>> create(ProductData data);
  Future<Result<Unit, Error>> update(ProductData data);
  Future<Result<Unit, Error>> delete(String uuid);
}
