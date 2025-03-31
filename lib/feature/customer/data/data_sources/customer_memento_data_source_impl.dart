import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/feature/customer/data/data_sources/customer_memento_data_source.dart';

class CustomerMementoDataSourceImpl implements CustomerMementoDataSource {
  final ShelfDatabase _database;

  CustomerMementoDataSourceImpl(this._database);

  @override
  Result<Stream<List<CustomerMementoData>>, Error> find(String customerUuid) {
    return Result.of(_database.getCustomerMementos(customerUuid).watch);
  }

  @override
  Future<Result<String, Error>> create(CustomerMementoData data) {
    return Result.asyncOf(() => _database
        .insertCustomerMemento(
          data.uuid,
          data.date,
          data.data,
          data.version,
          data.customer,
        )
        .then((result) => result.first));
  }
}
