import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'database.g.dart';

@DriftDatabase(
  include: {'tables.drift'},
)
class ShelfDatabase extends _$ShelfDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  ShelfDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'my_database',
      // By default, `driftDatabase` from `package:drift_flutter` stores the
      // database files in `getApplicationDocumentsDirectory()`.
      native: const DriftNativeOptions(),
    );
  }

  Future<List<ClientData>> getClients() {
    debugPrint('getting clients...');
    return select(client).get();
  }

  Future<void> addClient(Map<String, String?> data) async {
    // Insert the product into the table.
    await into(client).insert(
      ClientCompanion.insert(
        id: Uuid().v4(),
        name: data['name']!,
        document: data['document']!,
      ),
    );
    debugPrint('client just added $data');
  }

  Future<List<ProductData>> getProducts() {
    debugPrint('getting products...');
    return select(product).get();
  }

  Future<ProductData> getProduct(String id) async {
    debugPrint("Getting product with id: $id");
    return await (select(product)..where((p) => p.id.equals(id))).getSingle();
  }

  Future<ProductData> addProduct(Map<String, String> data) async {
    final id = Uuid().v4();

    // Insert the product into the table.
    await into(product).insert(
      ProductCompanion.insert(
        id: id,
        name: data['name']!,
        value: data['value']!.isEmpty ? 0 : int.parse(data['value']!),
        stock: data['stock']!.isEmpty ? 0 : int.parse(data['stock']!),
        code: data['code']!.isEmpty ? Value.absent() : Value(data['code']!),
      ),
    );
    debugPrint('product just added $data');

    return getProduct(id);
  }

  Future<void> addInvoice(Map<String, String> data) async {
    await into(invoice).insert(
      InvoiceCompanion.insert(
        id: data['uuid']!,
        number: 1,
        date: DateTime.now().toIso8601String(),
      ),
    );
  }

  Future<void> removeInvoice(String id) async {
    await (delete(invoice)..where((i) => i.id.equals(id))).go();
  }
}

@riverpod
ShelfDatabase database(Ref ref) {
  return ShelfDatabase();
}
