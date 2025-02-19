import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:project_shelf/database/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database.g.dart';

@riverpod
class Database extends _$Database {
  @override
  ShelfDatabase build() {
    return ShelfDatabase();
  }
}

@riverpod
class TestDatabase extends _$TestDatabase {
  @override
  ShelfDatabase build() {
    return ShelfDatabase.withExecutor(DatabaseConnection(
      NativeDatabase.memory(),
      closeStreamsSynchronously: true,
    ));
  }
}
