import 'package:drift/drift.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/providers/product/products.dart';

import 'util.dart';

void main() {
  Faker faker = Faker();

  test("creates product", () async {
    final container = createContainer();

    await container
        .read(productsProvider.notifier)
        .create(ProductCompanion.insert(
          name: faker.food.dish(),
          price: random.integer(999999),
          stock: random.integer(999),
          code: Value(faker.lorem.word()),
        ));
  }, tags: ["product"]);

  test("updates product", () async {
    final container = createContainer();

    final expected = await container
        .read(productsProvider.notifier)
        .create(ProductCompanion.insert(
          name: "Test",
          price: random.integer(999999),
          stock: random.integer(999),
          code: Value(faker.lorem.word()),
        ));

    final result = await container
        .read(productsProvider.notifier)
        .replace(expected.copyWith(name: "Tester"));

    expect(expected.name, "Test");
    expect(result.name, "Tester");
  }, tags: ["product"]);

  test("deletes product", () async {
    final container = createContainer();

    // Create product.
    final product = await container
        .read(productsProvider.notifier)
        .create(ProductCompanion.insert(
          name: "Test",
          price: random.integer(999999),
          stock: random.integer(999),
          code: Value(faker.lorem.word()),
        ));

    // Delete product.
    await container.read(productsProvider.notifier).delete(product.uuid);

    // Find the deleted product.
    final result = await container
        .read(productsProvider.notifier)
        .findByUuid(product.uuid);

    // Expect to not find the product in the database nor in the state.
    expect(result.isNone(), true);
    expect(
        await container
            .read(productsProvider.future)
            .then((products) => products.any((p) => p.uuid == product.uuid)),
        false);
  }, tags: ["product"]);
}
