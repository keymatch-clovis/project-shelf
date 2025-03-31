import "dart:io";
import "dart:typed_data";

import "package:oxidized/oxidized.dart";
import "package:path/path.dart";
import "package:project_shelf/shared/data/data_source/tables/customer.dart";
import "package:project_shelf/shared/data/data_source/tables/customer_memento.dart";
import "package:project_shelf/shared/data/data_source/tables/invoice.dart";
import "package:project_shelf/shared/data/data_source/tables/invoice_product.dart";
import "package:project_shelf/shared/data/data_source/tables/product.dart";
import "package:project_shelf/shared/data/data_source/tables/product_memento.dart";
import "package:sqflite/sqflite.dart";
import "package:sqflite/sqflite_dev.dart";
import "package:project_shelf/shared/data/data_source/tables/city.dart";

class DatabaseDataSource {
  Option<Database> _database = const Option.none();

  Option<String> get databasePath => _database.map((db) => db.path);

  Future<void> open({Option<Uint8List> bytes = const Option.none()}) async {
    final dbPath = await _getDatabasePath("shelf.sqlite");
    final dbFile = File(dbPath);

    // If we have a database already opened, we have to close this one to open
    // another.
    if (_database.isSome()) {
      print("Closing database");
      await _database.unwrap().close();
    }

    // If bytes provided, write them to the database location before opening.
    // We will assume the data is correctly backed up before doing this. >_>
    if (bytes.isSome()) {
      print("Writing bytes to database file: ${bytes.unwrap().length}");
      dbFile.writeAsBytesSync(bytes.unwrap());
    }

    print("Opening database");
    _database = Option.some(await sqfliteDatabaseFactoryDefault.openDatabase(
      dbPath,
      options: OpenDatabaseOptions(
        version: 3,
        onConfigure: _onConfigure,
        onCreate: (db, version) async {
          var batch = db.batch();

          createCityTable(batch);
          createProductTable(batch);
          createProductMementoTable(batch);
          createCustomerTable(batch);
          createCustomerMementoTable(batch);
          createInvoiceTable(batch);
          createInvoiceProductTable(batch);

          await batch.commit();
        },
        onUpgrade: _onUpgrade,
      ),
    ));
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print("Updating database from v$oldVersion, to v$newVersion");
    final batch = db.batch();

    switch (oldVersion) {
      case 1:
        print("Executing v1 -> v2 updates");
        updateInvoiceTableV1ToV2(batch);
        continue v2;
      v2:
      case 2:
        print("Executing v2 -> v3 updates");
        updateCityTableV2ToV3(batch);
        updateProductMementoTableV2ToV3(batch);
        updateCustomerTableV2ToV3(batch);
        updateCustomerMementoTableV2ToV3(batch);
        updateInvoiceTableV2ToV3(batch);
        updateInvoiceProductTableV2ToV3(batch);
    }

    await batch.commit();
  }

  _onConfigure(Database db) {
    return db.execute("PRAGMA foreign_keys = ON");
  }

  Future<String> _getDatabasePath(String databaseName) async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, databaseName);

    // Make sure the directory exists.
    await Directory(databasesPath).create(recursive: true);

    return path;
  }
}
