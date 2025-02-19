import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:project_shelf/database/aggregate.dart';
import 'package:project_shelf/database/database.dart';
import 'package:uuid/uuid.dart';

enum CommitType {
  CREATED,
  NAME_UPDATED,
  VALUE_UPDATED,
  STOCK_UPDATED,
  CODE_UPDATED,
}

// See more:
// https://stackoverflow.com/questions/7065045/using-an-rdbms-as-event-sourcing-storage
class Commit extends Table {
  TextColumn get uuid => text().clientDefault(() => const Uuid().v1())();
  DateTimeColumn get date => dateTime().withDefault(currentDate)();
  TextColumn get type => textEnum<CommitType>()();
  BlobColumn get data => blob()();
  IntColumn get version => integer()();

  TextColumn get aggregate => text().references(Aggregate, #uuid)();

  @override
  Set<Column<Object>> get primaryKey => {uuid};
}

String toString(CommitData commit) {
  return utf8.decode(commit.data);
}

int toInt(CommitData commit) {
  return int.parse(utf8.decode(commit.data));
}
