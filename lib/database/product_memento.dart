import 'package:drift/drift.dart';
import 'package:project_shelf/database/product.dart';
import 'package:uuid/uuid.dart';

class ProductMemento extends Table {
  late final uuid = text().clientDefault(() => Uuid().v1())();
  late final date = dateTime().withDefault(currentDate)();
  late final data = text()();
  late final version = integer()();

  /// References
  late final productUuid = text().references(Product, #uuid)();

  @override
  Set<Column<Object>> get primaryKey => {uuid};
}
