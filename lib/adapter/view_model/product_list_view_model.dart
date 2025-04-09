import 'package:project_shelf/adapter/view_model/product_view_model.dart';

class ProductListViewModel {
  bool isLoading = false;
  List<ProductViewModel> products = [];

  final Function(ProductViewModel) onProductSelected;

  ProductListViewModel({
    required this.onProductSelected,
  });
}
