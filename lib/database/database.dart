// NOTE: I don't really know how to do migrations with the SQL API, so I have
// to use the database member, that's why I have to ignore this alert.
// ignore_for_file: invalid_use_of_visible_for_overriding_member

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
import 'package:project_shelf/database/database.steps.dart';

part 'database.g.dart';

@DriftDatabase(
  include: {"tables.drift"},
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
  int get schemaVersion => 3;

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
      debugPrint("Migrating database v1 to v2");
      await m.alterTable(TableMigration(schema.invoice));
    },
    from2To3: (m, schema) async {
      // From 2 to 3:
      //   Change city name field from city to name.
      //   Change city id field from rowId to id.
      debugPrint("Migrating database v2 to v3");
      final invoiceProduct = InvoiceProduct(schema.database.attachedDatabase);
      final table = City(schema.database.attachedDatabase);

      // Change product_invoice to invoiceProduct.
      await m.renameTable(invoiceProduct, "product_invoice");

      await m.alterTable(
        TableMigration(
          table,
          columnTransformer: {
            table.name: const CustomExpression("city"),
            table.id: const CustomExpression("rowId"),
          },
        ),
      );
    },
  );
}
