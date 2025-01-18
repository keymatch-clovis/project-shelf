import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

@DriftDatabase(
  include: {'tables.drift'},
)
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase() : super(_openConnection());

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

  Future<List<ProductData>> get products => select(product).get();

  Future<List<ProductData>> search(String query) async {
    var test = await customSelect(
      '''
        select * from product_search(?) order by rank;
      ''',
      variables: [Variable.withString(query)],
      readsFrom: {productSearch},
    ).get();
    print('search $test');

    return Future.value([]);
  }

  Future<int> addProduct(ProductCompanion entry) async {
    // Insert the product into the table.
    var id = await into(product).insert(entry);

    // Insert the product data into the product search table.
    await into(productSearch).insert(
      ProductSearchCompanion(
        productId: Value(id.toString()),
        name: entry.name,
        code: Value(entry.code.value ?? ""),
      ),
    );

    return id;
  }
}
