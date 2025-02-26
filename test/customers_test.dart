import 'package:csv/csv.dart';
import 'package:drift/drift.dart';
import 'package:faker/faker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/providers/cities.dart';
import 'package:project_shelf/providers/customers.dart';

import 'util.dart';

void main() {
  Faker faker = Faker();

  TestWidgetsFlutterBinding.ensureInitialized();

  test("Loads departments and cities", () async {
    final input = await rootBundle.loadString("assets/departments_cities.csv");
    final fields = const CsvToListConverter().convert(input);
    final container = createContainer();

    for (final entry in fields) {
      await container
          .read(citiesProvider.notifier)
          .create(CityCompanion.insert(city: entry[1], department: entry[0]));
    }

    final cities = await container.read(citiesProvider.future);
    expect(cities.isNotEmpty, true);
  }, tags: ["customer"]);

  test("creates client", () async {
    final container = createContainer();

    final city = await container
        .read(citiesProvider.notifier)
        .create(CityCompanion.insert(
          city: faker.address.city(),
          department: faker.address.state(),
        ));

    await container
        .read(customersProvider.notifier)
        .create(CustomerCompanion.insert(
          name: faker.person.name(),
          phone: faker.phoneNumber.us(),
          address: faker.address.streetAddress(),
          businessName: Value(faker.person.firstName()),
          cityRowId: city.rowId,
        ));
  }, tags: ["customer"]);

  test("updates client", () async {
    final container = createContainer();

    final city = await container
        .read(citiesProvider.notifier)
        .create(CityCompanion.insert(
          city: faker.address.city(),
          department: faker.address.state(),
        ));

    final expected = await container
        .read(customersProvider.notifier)
        .create(CustomerCompanion.insert(
          name: "Test",
          phone: faker.phoneNumber.us(),
          address: faker.address.streetAddress(),
          businessName: Value(faker.person.firstName()),
          cityRowId: city.rowId,
        ));

    final result = await container.read(customersProvider.notifier).replace(
          expected.copyWith(name: "Tester"),
        );

    expect(expected.name, "Test");
    expect(result.name, "Tester");
  }, tags: ["customer"]);
}
