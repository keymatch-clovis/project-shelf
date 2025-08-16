import 'package:project_shelf/adapter/view_model/product_view_model.dart';

class ProductListViewModel {
  List<ProductViewModel> products;
  final Function(ProductViewModel) onProductSelected;

  ProductListViewModel({
    this.products = const [],
    required this.onProductSelected,
  });
}
