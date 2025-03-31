import 'package:sqflite/sqflite.dart';

void createProductTable(Batch batch) {
  print("Creating Product table");
  batch.execute("""
    CREATE TABLE IF NOT EXISTS product (
      uuid  TEXT NOT NULL PRIMARY KEY,
      name  TEXT NOT NULL,
      price INTEGER NOT NULL DEFAULT 0,
      stock INTEGER NOT NULL DEFAULT 0
    );
  """);
}
