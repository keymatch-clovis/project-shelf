import 'package:drift/drift.dart';
import 'package:project_shelf/database/invoice.dart';
import 'package:project_shelf/database/product.dart';

class ProductInvoice extends Table {
  late final price = integer()();
  late final count = integer()();
  late final discount = integer().clientDefault(() => 0)();

  /// References.
  late final productUuid = text().references(Product, #uuid)();
  late final invoiceUuid = text().references(Invoice, #uuid)();

  @override
  Set<Column<Object>> get primaryKey => {productUuid, invoiceUuid};
}
