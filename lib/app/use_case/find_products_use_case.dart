import 'package:project_shelf/shared/domain/entity/product.dart';
import 'package:project_shelf/shared/gateway/product_gateway.dart';

class FindProductsUseCase {
  final ProductGateway _gateway;

  FindProductsUseCase(this._gateway);

  Future<List<Product>> execute() {
    return _gateway.find();
  }
}
