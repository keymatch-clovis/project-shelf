import 'package:sqflite/sqflite.dart';

void createInvoiceProductTable(Batch batch) {
  print("Creating InvoiceProduct table");
  batch.execute("""
    CREATE TABLE IF NOT EXISTS invoice_product (
      count     INTEGER NOT NULL,
      price     INTEGER NOT NULL,
      discount  INTEGER NOT NULL DEFAULT 0,
      invoice   TEXT NOT NULL REFERENCES invoice(uuid),
      product   TEXT NOT NULL REFERENCES product(uuid),
      PRIMARY KEY (invoice, product)
    );
  """);
}

void updateInvoiceProductTableV2ToV3(Batch batch) {
  print("Updating InvoiceProduct table: v2 -> v3");
  batch.execute("ALTER TABLE product_invoice RENAME TO invoice_product");
}
