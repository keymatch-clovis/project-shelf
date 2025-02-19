import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:project_shelf/database/aggregate.dart';
import 'package:project_shelf/database/aggregate_dao.dart';
import 'package:project_shelf/database/commit.dart';
import 'package:project_shelf/database/commit_dao.dart';
import 'package:uuid/uuid.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [Commit, Aggregate],
  daos: [CommitDao, AggregateDao],
)
class ShelfDatabase extends _$ShelfDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/

  // This constructor is for when the application is used in production.
  ShelfDatabase() : super(_openConnection());

  // This constructor is for tests only.
  ShelfDatabase.withExecutor(super.executor);

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
}
