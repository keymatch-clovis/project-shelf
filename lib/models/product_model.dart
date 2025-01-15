class CreateProductModel {
  String name;
  int value;
  String code;
  int stock;

  CreateProductModel({
    required this.name,
    required this.value,
    required this.code,
    required this.stock,
  });

  Map<String, Object?> toMap() {
    return {
      'name': name,
      'value': value,
      'code': code,
      'stock': stock,
    };
  }

  @override
  String toString() {
    return 'CreateProductModel{name: $name, value: $value, code: $code, stock: $stock}';
  }
}

class ProductModel {
  int id;
  String name;
  int value;
  String code;
  int stock;

  ProductModel({
    required this.id,
    required this.name,
    required this.value,
    required this.code,
    required this.stock,
  });

  static ProductModel emptyProduct() {
    return ProductModel(id: 0, name: "", value: 0, code: "", stock: 0);
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'value': value,
      'code': code,
      'stock': stock,
    };
  }

  @override
  String toString() {
    return 'ProductModel{id: $id, name: $name, value: $value, code: $code, stock: $stock}';
  }
}
