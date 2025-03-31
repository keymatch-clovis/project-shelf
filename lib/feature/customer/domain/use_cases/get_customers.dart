import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/feature/customer/domain/entities/customer_entity.dart';
import 'package:project_shelf/feature/customer/domain/repositories/customer_repository.dart';

class GetCustomers {
  final CustomerRepository repository;

  GetCustomers(this.repository);

  Result<Stream<List<CustomerEntity>>, Error> getCustomers() {
    return this.repository.getCustomers();
  }
}
