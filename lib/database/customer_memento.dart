import 'package:drift/drift.dart';
import 'package:project_shelf/database/customer.dart';
import 'package:uuid/uuid.dart';

class CustomerMemento extends Table {
  TextColumn get uuid => text().clientDefault(() => Uuid().v1())();
  DateTimeColumn get date => dateTime().withDefault(currentDateAndTime)();
  TextColumn get data => text()();
  IntColumn get version => integer()();

  /// Foreign keys.
  TextColumn get customerUuid => text().references(Customer, #uuid)();

  @override
  Set<Column<Object>> get primaryKey => {uuid};
}
