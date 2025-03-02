import 'package:drift/drift.dart';
import 'package:project_shelf/database/invoice.dart';
import 'package:project_shelf/database/product.dart';

class ProductInvoice extends Table {
  late final count = integer()();
  late final price = int64().clientDefault(() => BigInt.from(0))();
  late final discount = int64().clientDefault(() => BigInt.from(0))();

  /// References.
  late final productUuid = text().references(Product, #uuid)();
  late final invoiceUuid = text().references(Invoice, #uuid)();

  @override
  Set<Column<Object>> get primaryKey => {productUuid, invoiceUuid};
}
