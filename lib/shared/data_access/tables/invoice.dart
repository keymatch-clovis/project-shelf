import 'package:sqflite/sqflite.dart';

void createInvoiceTable(Batch batch) {
  print("Creating Invoice table");
  batch.execute("""
    CREATE TABLE IF NOT EXISTS invoice (
      uuid          TEXT PRIMARY KEY,
      number        INTEGER NOT NULL UNIQUE,
      date          INTEGER NOT NULL,
      discount      INTEGER NOT NULL DEFAULT 0,
      address       TEXT NOT NULL,
      customer      TEXT NOT NULL REFERENCES customer(uuid)
    );
  """);
}

void updateInvoiceTableV1ToV2(Batch batch) {
  print("Updating Invoice table: v1 -> v2");
  batch.execute("""
    CREATE UNIQUE INDEX ux_invoice_number ON invoice(number);
  """);
}

void updateInvoiceTableV2ToV3(Batch batch) {
  print("Updating Invoice table: v2 -> v3");
  batch.execute("ALTER TABLE invoice RENAME COLUMN customer_uuid TO customer");
}
