import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/database/database.dart';

// In Clean Architecture, we define the models with the data we want to use.
// As this data comes directly from our database, we can use the Drift created
// classes, and try to optimize the code.

// NOTE: I think this class is very closely related to the repository class in
// the domain layer.
abstract class CustomerDataSource {
  Result<Stream<List<GetCustomersResult>>, Error> find();
  Future<Result<GetCustomerByUuidResult, Error>> findByUuid(String uuid);
  Future<Result<String, Error>> create(CustomerData entity);
  Future<Result<Unit, Error>> update(CustomerData entity);
  Future<Result<Unit, Error>> delete(String uuid);
}
