import 'package:drift/drift.dart';
import 'package:project_shelf/database/city.dart';
import 'package:uuid/uuid.dart';

class Customer extends Table {
  late final uuid = text().clientDefault(() => Uuid().v1())();
  late final name = text()();
  late final phone = text()();
  late final address = text()();
  late final cityRowId = integer().references(City, #rowId)();

  /// Nullable
  late final businessName = text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {uuid};
}
