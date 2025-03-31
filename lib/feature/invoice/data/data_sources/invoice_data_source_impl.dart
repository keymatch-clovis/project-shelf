import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/feature/invoice/data/data_sources/invoice_data_source.dart';

class InvoiceDataSourceImpl implements InvoiceDataSource {
  final ShelfDatabase _database;

  InvoiceDataSourceImpl(this._database);

  @override
  Future<Result<String, Error>> create(
      InvoiceData data, List<InvoiceProductData> products) {
    return Result.asyncOf(() {
      return _database
          .insertInvoice(
            data.uuid,
            data.number,
            data.date,
            data.discount,
            data.customer,
          )
          .then((result) => result.first);
    });
  }

  @override
  Result<Stream<List<InvoiceData>>, Error> find() {
    return Result.of(_database.getInvoices().watch);
  }

  @override
  Future<Result<InvoiceData, Error>> findByUuid(String uuid) {
    return Result.asyncOf(() {
      return _database.getInvoiceByUuid(uuid).getSingle();
    });
  }

  @override
  Future<Result<Unit, Error>> createInvoiceProduct(InvoiceProductData data) {
    return Result.asyncOf(() {
      return _database
          .insertInvoiceProduct(
            data.count,
            data.price,
            data.discount,
            data.invoice,
            data.product,
          )
          .then((_) => Unit.unit);
    });
  }
}
