import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:drift/internal/versioned_schema.dart';
import 'package:flutter/foundation.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:drift/native.dart';
import 'package:oxidized/oxidized.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_shelf/database/city.dart';
import 'package:project_shelf/database/customer.dart';
import 'package:project_shelf/database/customer_memento.dart';
import 'package:project_shelf/database/invoice.dart';
import 'package:project_shelf/database/product.dart';
import 'package:project_shelf/database/product_invoice.dart';
import 'package:project_shelf/database/product_memento.dart';
import 'package:uuid/uuid.dart';
import 'package:project_shelf/database/database.steps.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    City,
    Customer,
    CustomerMemento,
    Invoice,
    Product,
    ProductInvoice,
    ProductMemento,
  ],
)
class ShelfDatabase extends _$ShelfDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/

  // This constructor is for when the application is used in production.
  ShelfDatabase({
    Option<Uint8List> bytes = const Option.none(),
  }) : super(_openConnection(bytes));

  // This constructor is for tests only.
  ShelfDatabase.withExecutor(super.executor);

  @override
  int get schemaVersion => 2;

  static LazyDatabase _openConnection(Option<Uint8List> bytes) {
    return LazyDatabase(() async {
      // put the database file into the documents folder for your app.
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(join(dbFolder.path, "shelf.sqlite"));

      if (bytes.isSome()) {
        // Extract the pre-populated database file.
        file.writeAsBytesSync(bytes.unwrap());
      }

      // Make sqlite3 pick a more suitable location for temporary files - the
      // one from the system may be inaccessible due to sandboxing.
      final cachebase = (await getTemporaryDirectory()).path;
      // We can't access /tmp on Android, which sqlite3 would try by default.
      // Explicitly tell it about the correct temporary directory.
      sqlite3.tempDirectory = cachebase;

      return NativeDatabase.createInBackground(file);
    });
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: (m, from, to) async {
        // Following the advice from https://drift.simonbinder.eu/Migrations/api/#general-tips
        await customStatement('PRAGMA foreign_keys = OFF');

        await transaction(
          () => VersionedSchema.runMigrationSteps(
            migrator: m,
            from: from,
            to: to,
            steps: _upgrade,
          ),
        );

        await customStatement('PRAGMA foreign_keys = ON');
      },
      beforeOpen: (_) async {
        if (kDebugMode) {
          await validateDatabaseSchema();
        }
      },
    );
  }

  static final _upgrade = migrationSteps(
    from1To2: (m, schema) async {
      // From 1 to 2: Mark invoice number as unique.
      await m.alterTable(TableMigration(schema.invoice));
    },
  );
}
