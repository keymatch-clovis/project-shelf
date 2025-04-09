import 'package:sqflite/sqflite.dart';

void createCityTable(Batch batch) {
  print("Creating City table");
  batch.execute("""
    CREATE TABLE IF NOT EXISTS city (
      id          INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      name        TEXT NOT NULL,
      department  TEXT NOT NULL
    );
  """);
}

void updateCityTableV2ToV3(Batch batch) {
  print("Updating City table: v2 -> v3");
  batch.execute("ALTER TABLE city RENAME COLUMN row_id TO id");
  batch.execute("ALTER TABLE city RENAME COLUMN city TO name");
}
