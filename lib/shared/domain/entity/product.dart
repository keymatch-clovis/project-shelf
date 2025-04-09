class Product {
  String uuid;
  String name;
  int price;
  int stock;

  Product({
    required this.uuid,
    required this.name,
    this.price = 0,
    this.stock = 0,
  });

  factory Product.fromMap(Map<String, Object?> map) {
    return Product(
      uuid: map["uuid"].toString(),
      name: map["name"].toString(),
      price: int.parse(map["price"].toString()),
      stock: int.parse(map["stock"].toString()),
    );
  }
}
