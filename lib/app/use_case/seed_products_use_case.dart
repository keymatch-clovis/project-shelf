import 'package:project_shelf/shared/gateway/product_gateway.dart';
// We can import this here, as this is only expected to work in a development
// environment.
// ignore: depend_on_referenced_packages
import 'package:faker/faker.dart';

class SeedProductsUseCase {
  final ProductGateway _gateway;

  SeedProductsUseCase(this._gateway);

  Future<void> execute({
    int amount = 5,
  }) async {
    final faker = Faker();

    for (final _ in Iterable.generate(amount)) {
      await _gateway.create(
        name: faker.food.dish(),
        price: random.integer(1000000),
        stock: random.integer(100),
      );
    }
  }
}
