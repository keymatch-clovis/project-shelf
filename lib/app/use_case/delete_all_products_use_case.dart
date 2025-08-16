import 'package:project_shelf/shared/gateway/product_gateway.dart';

class DeleteAllProductsUseCase {
  final ProductGateway _gateway;

  DeleteAllProductsUseCase(this._gateway);

  Future<void> execute() {
    // Delete all products from the database.
    return _gateway.deleteAll();
  }
}
