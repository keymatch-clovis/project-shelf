import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/feature/customer/domain/repositories/customer_repository.dart';

class CreateCustomer {
  final CustomerRepository repository;

  CreateCustomer(this.repository);

  Result<Unit, Error> createCustomer() {
    repository.createCustomer();

    return Result.ok(Unit.unit);
  }
}
