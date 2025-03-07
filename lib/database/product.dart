import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

class Product extends Table {
  late final uuid = text().clientDefault(() => Uuid().v1())();
  late final name = text()();
  late final price = int64().clientDefault(() => BigInt.from(0))();
  late final stock = integer().clientDefault(() => 0)();

  @override
  Set<Column<Object>> get primaryKey => {uuid};
}
