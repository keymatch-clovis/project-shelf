import 'package:drift/drift.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/providers/cities.dart';
import 'package:project_shelf/providers/customers.dart';
import 'package:project_shelf/providers/invoice/invoices.dart';
import 'package:project_shelf/providers/product/products.dart';
import 'package:uuid/uuid.dart';

import 'util.dart';

void main() {
  Faker faker = Faker();

  test("creates invoice", () async {
    final container = createContainer();

    final city = await container
        .read(citiesProvider.notifier)
        .create(CityCompanion.insert(
          city: faker.address.city(),
          department: faker.address.state(),
        ));

    final customer = await container.read(customersProvider.notifier).create(
          CustomerCompanion.insert(
            name: faker.person.name(),
            phone: faker.phoneNumber.us(),
            address: faker.address.streetAddress(),
            businessName: Value(faker.person.firstName()),
            cityRowId: city.rowId,
          ),
        );

    final consecutive =
        await container.read(invoicesProvider.notifier).getConsecutive();
    final invoice = await container.read(invoicesProvider.notifier).create(
          InvoiceCompanion.insert(
            number: consecutive,
            customerUuid: customer.uuid,
          ),
        );

    for (final _ in Iterable.generate(5)) {
      final product = await container
          .read(productsProvider.notifier)
          .create(ProductCompanion.insert(
            // We are creating them too fast, so UUIDv1 fails.
            uuid: Value(Uuid().v4()),
            name: faker.food.dish(),
            price: random.integer(999999),
            stock: random.integer(999),
          ));

      await container.read(invoicesProvider.notifier).addProduct(
            ProductInvoiceCompanion.insert(
              price: product.price,
              count: 1,
              productUuid: product.uuid,
              invoiceUuid: invoice.uuid,
            ),
          );
    }

    final result = await container
        .read(invoicesProvider.notifier)
        .findByUuid(invoice.uuid);

    expect(result.isSome(), true);
    expect(result.unwrap().products.isNotEmpty, true);
  }, tags: ["invoice"]);
}
