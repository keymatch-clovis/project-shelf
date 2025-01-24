import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database.g.dart';

const maxPageSize = 100;

@DriftDatabase(
  include: {'tables.drift'},
)
class ShelfDatabase extends _$ShelfDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  ShelfDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'my_database',
      // By default, `driftDatabase` from `package:drift_flutter` stores the
      // database files in `getApplicationDocumentsDirectory()`.
      native: const DriftNativeOptions(),
    );
  }

  Future<List<ProductData>> getProducts({int page = 0}) {
    return (select(product)
          ..orderBy([(p) => OrderingTerm(expression: p.rowId)])
          ..limit(maxPageSize, offset: page * maxPageSize))
        .get();
  }

  Future<int> addProduct(ProductCompanion entry) async {
    // Insert the product into the table.
    var id = await into(product).insert(entry);
    debugPrint('product just added $entry');

    return id;
  }
}

@riverpod
ShelfDatabase database(Ref ref) {
  return ShelfDatabase();
}
