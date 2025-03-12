import 'package:drift/drift.dart';
import 'package:project_shelf/database/customer.dart';
import 'package:uuid/uuid.dart';

class Invoice extends Table {
  late final uuid = text().clientDefault(() => Uuid().v1())();
  late final number = integer().unique()();
  late final date = dateTime().withDefault(currentDateAndTime)();
  late final discount = integer().clientDefault(() => 0)();

  /// References.
  late final customerUuid = text().references(Customer, #uuid)();

  @override
  Set<Column<Object>> get primaryKey => {uuid};
}
