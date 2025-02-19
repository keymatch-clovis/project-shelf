import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

enum AggregateType {
  PRODUCT,
}

class Aggregate extends Table {
  TextColumn get uuid => text().clientDefault(() => const Uuid().v4())();
  TextColumn get type => textEnum<AggregateType>()();
  IntColumn get version => integer()();

  @override
  Set<Column<Object>> get primaryKey => {uuid};
}
