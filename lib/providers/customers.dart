import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/providers/customer_mementos.dart';
import 'package:project_shelf/providers/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "customers.g.dart";

const CURRENT_CUSTOMER_VERSION = 1;

@riverpod
class Customers extends _$Customers {
  @override
  Future<List<CustomerData>> build() async {
    return _find();
  }

  Future<CustomerData> create(CustomerCompanion data) async {
    final database = ref.watch(databaseProvider);

    debugPrint("Creating customer: $data");
    final customer =
        await (database.into(database.customer).insertReturning(data));
    debugPrint("Customer created: $customer");

    await _invalidate();
    return customer;
  }

  Future<void> replace(CustomerData data) async {
    final database = ref.watch(databaseProvider);

    await database.transaction(() async {
      final old = await findByUuid(data.uuid).unwrap();

      // See more: https://refactoring.guru/design-patterns/memento
      await ref.read(customerMementosProvider(data.uuid).notifier).create(old);

      debugPrint("updating customer: $data");
      await (database.update(database.customer).replace(data));
      debugPrint("customer updated");

      await _invalidate();
    });
  }

  Future<Option<CustomerData>> findByUuid(String uuid) async {
    final database = ref.watch(databaseProvider);
    return (database.select(database.customer)
          ..where((c) => c.uuid.equals(uuid)))
        .getSingleOrNull()
        .then((c) => Option.from(c));
  }

  Future<void> delete(String uuid) async {
    final database = ref.watch(databaseProvider);

    debugPrint("deleting customer: $uuid");
    await database.transaction(() async {
      // Remove customer mementos.
      await ref.watch(customerMementosProvider(uuid).notifier).deleteAll();

      // Remove customer.
      return await (database.delete(database.customer)
            ..where((p) => p.uuid.equals(uuid)))
          .goAndReturn()
          .then((customers) => customers.first);
    });
    debugPrint("customer deleted: $uuid");

    await _invalidate();
  }

  Future<void> TEST_load() async {
    debugPrint("Loading test customer data...");
    final database = ref.watch(databaseProvider);
    final input = await rootBundle.loadString("assets/customer.csv");
    final fields =
        const CsvToListConverter().convert(input, shouldParseNumbers: false);

    for (final field in fields) {
      debugPrint("Inserting: $field");
      await (database.into(database.customer).insert(
            CustomerCompanion.insert(
              uuid: Value(field[0]),
              name: field[1],
              businessName: Value(field[2]),
              address: field[3],
              phone: field[4],
              cityRowId: int.parse(field[5]),
            ),
          ));
    }

    await _invalidate();
  }

  Future<List<CustomerData>> _find() async {
    final database = ref.watch(databaseProvider);
    return database.select(database.customer).get();
  }

  Future<void> _invalidate() async {
    // This will cause "build" on our notifier to asynchronously be called again,
    // and will notify listeners when doing so.
    ref.invalidateSelf();

    // (Optional) We can then wait for the new state to be computed.
    // This ensures "addTodo" does not complete until the new state is available.
    await future;
  }
}
