import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/feature/customer/domain/entities/customer_entity.dart';

abstract class CustomerRepository {
  Result<Stream<List<CustomerEntity>>, Error> find();
  Future<Result<CustomerEntity, Error>> findByUuid(String uuid);
  Future<Result<String, Error>> create(CustomerEntity entity);
  Future<Result<Unit, Error>> update(CustomerEntity entity);
  Future<Result<Unit, Error>> delete(String uuid);
}
