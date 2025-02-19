import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/model/product.dart';
import 'package:project_shelf/providers/products.dart';

/// A testing utility which creates a [ProviderContainer] and automatically
/// disposes it at the end of the test.
ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  // Create a ProviderContainer, and optionally allow specifying parameters.
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );

  // When the test ends, dispose the container.
  addTearDown(container.dispose);

  return container;
}

void main() {
  Faker faker = Faker();

  test("Creates products", () async {
    final container = createContainer();
    final expectedProducts = List.generate(
      10,
      (_) => Product(
        name: faker.food.dish(),
        value: random.integer(9999),
        stock: random.integer(9999),
        code: faker.lorem.word(),
      ),
    );

    // Create products.
    for (final expectedProduct in expectedProducts) {
      final result = await container
          .read(productsProvider.notifier)
          .create(expectedProduct);
      expect(result.product, expectedProduct);
    }

    // Expect all products to be in the state.
    for (final expectedProduct in expectedProducts) {
      final state = await container.read(productsProvider.future);
      expect(
        state.products.any((a) => a.product == expectedProduct),
        true,
      );
    }
  });

  test("Creates client", () async {});
}
