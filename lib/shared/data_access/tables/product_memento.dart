import 'package:sqflite/sqflite.dart';

void createProductMementoTable(Batch batch) {
  print("Creating Product Memento table");
  batch.execute("""
    CREATE TABLE IF NOT EXISTS product_memento (
      uuid      TEXT PRIMARY KEY,
      date      INTEGER NOT NULL
      data      TEXT NOT NULL,
      version   INTEGER NOT NULL,
      product   TEXT NOT NULL REFERENCES product(uuid)
    );
  """);
}

void updateProductMementoTableV2ToV3(Batch batch) {
  print("Updating Product Memento table: v2 -> v3");
  batch.execute("""
    ALTER TABLE product_memento RENAME COLUMN product_uuid TO product
  """);
}
