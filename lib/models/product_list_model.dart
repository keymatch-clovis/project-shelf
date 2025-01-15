import 'package:flutter/foundation.dart';
import 'package:project_shelf/database/providers/product_provider.dart';
import 'package:project_shelf/models/product_model.dart';

class ProductListModel extends ChangeNotifier {
  late List<ProductModel> products;

  Future<void> loadProducts() async {
    var provider = await ProductProvider.create();
    products = await provider.get();
    print(products);
    notifyListeners();
  }
}
