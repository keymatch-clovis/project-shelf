import 'package:sqflite/sqflite.dart';

void createCustomerMementoTable(Batch batch) {
  print("Creating Customer Memento table");
  batch.execute("""
    CREATE TABLE IF NOT EXISTS customer_memento (
      uuid          TEXT PRIMARY KEY,
      date          INTEGER NOT NULL
      data          TEXT NOT NULL,
      version       INTEGER NOT NULL,
      customer      TEXT NOT NULL REFERENCES customer(uuid)
    );
  """);
}

void updateCustomerMementoTableV2ToV3(Batch batch) {
  print("Updating Customer Memento table: v2 -> v3");
  batch.execute("""
    ALTER TABLE customer_memento RENAME COLUMN customer_uuid TO customer
  """);
}
