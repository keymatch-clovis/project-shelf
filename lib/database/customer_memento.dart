import 'package:drift/drift.dart';
import 'package:project_shelf/database/customer.dart';
import 'package:uuid/uuid.dart';

class CustomerMemento extends Table {
  TextColumn get uuid => text().clientDefault(() => Uuid().v1())();
  DateTimeColumn get date => dateTime().withDefault(currentDate)();
  TextColumn get data => text()();
  IntColumn get version => integer()();
  // Foreign key.
  TextColumn get clientUuid => text().references(Customer, #uuid)();

  @override
  Set<Column<Object>> get primaryKey => {uuid};
}
