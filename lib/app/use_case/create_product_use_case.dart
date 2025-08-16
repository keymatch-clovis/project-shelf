import 'package:project_shelf/shared/domain/entity/product.dart';
import 'package:project_shelf/shared/gateway/product_gateway.dart';

class CreateProductUseCase {
  final ProductGateway _gateway;

  CreateProductUseCase(this._gateway);

  Future<Product> execute({
    required String name,
    required String price,
    required String stock,
  }) {
    return _gateway.create(
      name: name,
      price: int.parse(price),
      stock: int.parse(stock),
    );
  }
}
