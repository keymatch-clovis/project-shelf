import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:drift/drift.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/lib/error.dart';
import 'package:project_shelf/providers/customer_mementos.dart';
import 'package:project_shelf/providers/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "customers.g.dart";

const CURRENT_CUSTOMER_VERSION = 1;

class CustomerWithCity {
  final CustomerData customer;
  final CityData city;

  const CustomerWithCity({
    required this.customer,
    required this.city,
  });
}

@riverpod
class Customers extends _$Customers {
  @override
  Future<List<CustomerWithCity>> build() async {
    return _find();
  }

  Future<Result<Unit, FileLoadError>> uploadCustomers() async {
    final file = await FilePicker.platform
        .pickFiles(
          dialogTitle: "Seleccionar archivo de datos",
          allowMultiple: false,
          withData: true,
        )
        .then((r) => Option.from(r));

    if (file.isNone()) {
      return Err(FileLoadError.FILE_NOT_SELECTED);
    }

    final data = Result.of(() {
      final decoded = utf8.decode(file.unwrap().files.single.bytes!);
      return const CsvToListConverter()
          .convert(decoded, shouldParseNumbers: false);
    });

    if (data.isErr()) {
      debugPrint(data.unwrapErr().toString());
      return Err(FileLoadError.BROKEN_FILE);
    }

    final rows = data.unwrap();
    final database = ref.watch(databaseProvider);

    return await Result.asyncOf(() async {
      for (final row in rows) {
        debugPrint("Creating customer: $row");
        await (database.into(database.customer).insert(
              CustomerCompanion.insert(
                uuid: Value(row[0]),
                name: row[1],
                businessName: Value(row[2]),
                address: row[3],
                phone: row[4],
                cityRowId: int.parse(row[5]),
              ),
            ));
      }
      debugPrint("Customer loaded");

      // Invalidate the state once all the products have loaded.
      await _invalidate();

      return Unit.unit;
    }).mapErr((err) {
      debugPrint(err.toString());
      return FileLoadError.INCORRECT_FILE_FORMAT;
    });
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

  Future<List<CustomerWithCity>> _find() async {
    final database = ref.watch(databaseProvider);
    final query = database.select(database.customer).join([
      innerJoin(database.city,
          database.customer.cityRowId.equalsExp(database.city.rowId)),
    ]);

    return query.map((rows) {
      return CustomerWithCity(
        customer: rows.readTable(database.customer),
        city: rows.readTable(database.city),
      );
    }).get();
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
