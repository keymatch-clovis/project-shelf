import 'package:drift/drift.dart';

class City extends Table {
  late final rowId = integer().autoIncrement()();
  late final city = text()();
  late final department = text()();
}
