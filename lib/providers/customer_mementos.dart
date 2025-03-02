import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/providers/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:oxidized/oxidized.dart';

part 'customer_mementos.g.dart';

const CURRENT_VERSION = 1;

class CustomerMementosState {
  final String customerUuid;
  final List<CustomerMementoData> mementos;

  const CustomerMementosState({
    required this.customerUuid,
    required this.mementos,
  });
}

@riverpod
class CustomerMementos extends _$CustomerMementos {
  @override
  Future<CustomerMementosState> build(String customerUuid) async {
    return CustomerMementosState(
      customerUuid: customerUuid,
      mementos: await _find(customerUuid),
    );
  }

  Future<void> create(CustomerData data) async {
    final database = ref.watch(databaseProvider);
    final customerUuid = await future.then((s) => s.customerUuid);

    debugPrint("Creating memento: $data");
    final memento = await (database
        .into(database.customerMemento)
        .insertReturning(CustomerMementoCompanion.insert(
          data: jsonEncode(data.toJson()),
          version: CURRENT_VERSION,
          customerUuid: customerUuid,
        )));
    debugPrint("Memento created: $memento");

    await _invalidate();
  }

  Future<List<CustomerMementoData>> deleteAll() async {
    final database = ref.watch(databaseProvider);
    final customerUuid = await future.then((s) => s.customerUuid);

    debugPrint("deleting mementos from customer: $customerUuid");
    final mementos = await (database.delete(database.customerMemento)
          ..where((pm) => pm.customerUuid.equals(customerUuid)))
        .goAndReturn();
    debugPrint("mementos deleted: $mementos");

    await _invalidate();
    return mementos;
  }

  Future<Option<CustomerMementoData>> findByUuid(String uuid) async {
    final database = ref.watch(databaseProvider);
    return (database.select(database.customerMemento)
          ..where((pm) => pm.uuid.equals(uuid)))
        .getSingleOrNull()
        .then((pm) => Option.from(pm));
  }

  Future<List<CustomerMementoData>> _find(String customerUuid) async {
    final database = ref.watch(databaseProvider);
    return (database.select(database.customerMemento)
          ..where((pm) => pm.customerUuid.equals(customerUuid)))
        .get();
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
