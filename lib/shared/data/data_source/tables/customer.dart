import 'package:sqflite/sqflite.dart';

void createCustomerTable(Batch batch) {
  print("Creating Customer table");
  batch.execute("""
    CREATE TABLE IF NOT EXISTS customer (
      uuid          TEXT PRIMARY KEY,
      name          TEXT NOT NULL
      phone         TEXT NOT NULL,
      address       TEXT NOT NULL,
      business_name TEXT,
      city          INTEGER NOT NULL REFERENCES city(id)
    );
  """);
}

void updateCustomerTableV2ToV3(Batch batch) {
  print("Updating Customer table: v2 -> v3");
  batch.execute("ALTER TABLE customer RENAME COLUMN city_row_id TO city");
}
