import 'package:flutter/foundation.dart';

class ProductViewModel with ChangeNotifier {
  String name;
  String price;
  String stock;

  ProductViewModel({
    required this.name,
    required this.price,
    required this.stock,
  });
}
