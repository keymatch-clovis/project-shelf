import 'dart:typed_data';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/shared/data/data_source/database_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final databaseProvider =
    AutoDisposeNotifierProvider<DatabaseProvider, DatabaseDataSource>(
        DatabaseProvider.new);

class DatabaseProvider extends AutoDisposeNotifier<DatabaseDataSource> {
  @override
  DatabaseDataSource build() {
    // NOTE: We want to keep this provider alive for as long as possible, as the
    // account that the data source references might be useful at all times.
    ref.keepAlive();
    return DatabaseDataSource();
  }

  Future loadDatabase(Uint8List bytes) async {
    print("Loading database");

    await state.open(bytes: Option.from(bytes));
    ref.notifyListeners();
  }
}
