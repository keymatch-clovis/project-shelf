import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

class Product extends Table {
  late final uuid = text().clientDefault(() => Uuid().v1())();
  late final name = text()();
  late final price = int64()();
  late final stock = integer()();
  late final code = text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {uuid};
}
