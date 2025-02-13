import 'package:flutter/material.dart';
import 'package:project_shelf/database/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'clients.g.dart';

@riverpod
class Clients extends _$Clients {
  @override
  FutureOr<List<ClientData>> build() {
    return ref.watch(databaseProvider).getClients();
  }

  Future<void> add(Map<String, String?> data) async {
    debugPrint('Adding new client');
    debugPrint('$data');
    await ref.watch(databaseProvider).addClient(data);

    // Once the creation is done, we mark the local cache as dirty. This will
    // cause "build" to be asynchronously be called again.
    ref.invalidateSelf();
    // (Optional) Wait for the new state to be computed.
    await future;
  }
}
