import 'package:go_router/go_router.dart';
import 'package:project_shelf/adapter/view_model/product_list_view_model.dart';
import 'package:project_shelf/app/use_case/find_products_use_case.dart';

class ProductPresenter {
  final FindProductsUseCase findProductsUseCase;

  ProductPresenter({
    required this.findProductsUseCase,
  });

  ProductListViewModel presentProductList(GoRouter router) {
    return ProductListViewModel(
      onProductSelected: (product) => router.go(
        "/products/product",
        extra: product,
      ),
    );
  }
}
