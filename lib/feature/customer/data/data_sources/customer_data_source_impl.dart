import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/feature/customer/data/data_sources/customer_data_source.dart';

class CustomerDataSourceImpl implements CustomerDataSource {
  final ShelfDatabase _database;

  CustomerDataSourceImpl(this._database);

  @override
  Result<Stream<List<GetCustomersResult>>, Error> find() {
    return Result.of(_database.getCustomers().watch);
  }

  @override
  Future<Result<GetCustomerByUuidResult, Error>> findByUuid(String uuid) {
    return Result.asyncOf(() {
      return _database.getCustomerByUuid(uuid).getSingle();
    });
  }

  @override
  Future<Result<String, Error>> create(CustomerData entity) {
    return Result.asyncOf(() => _database
        .insertCustomer(
          entity.uuid,
          entity.name,
          entity.phone,
          entity.address,
          entity.businessName,
          entity.city,
        )
        .then((result) => result.first!));
  }

  @override
  Future<Result<Unit, Error>> delete(String uuid) {
    return Result.asyncOf(() {
      return _database.deleteCustomer(uuid).then((_) => Unit.unit);
    });
  }

  @override
  Future<Result<Unit, Error>> update(CustomerData entity) {
    return Result.asyncOf(() {
      return _database
          .updateCustomer(
            entity.name,
            entity.phone,
            entity.address,
            entity.businessName,
            entity.city,
            entity.uuid,
          )
          .then((_) => Unit.unit);
    });
  }
}
