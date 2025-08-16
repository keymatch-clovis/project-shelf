import 'package:go_router/go_router.dart';
import 'package:project_shelf/adapter/view_model/product_list_view_model.dart';
import 'package:project_shelf/adapter/view_model/product_view_model.dart';
import 'package:project_shelf/app/use_case/find_products_use_case.dart';

class ProductPresenter {
  final FindProductsUseCase findProductsUseCase;

  ProductPresenter({
    required this.findProductsUseCase,
  });

  Future<ProductListViewModel> presentProductList(GoRouter router) async {
    final products = await this.findProductsUseCase.execute().then((result) {
      return result
          .map((product) => ProductViewModel(
                name: product.name,
                price: product.price.toString(),
                stock: product.stock.toString(),
              ))
          .toList();
    });

    return ProductListViewModel(
      products: products,
      onProductSelected: (product) => router.go(
        "/products/product",
        extra: product,
      ),
    );
  }
}
