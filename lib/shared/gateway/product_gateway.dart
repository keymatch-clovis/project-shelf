import 'package:project_shelf/shared/domain/entity/product.dart';

abstract interface class ProductGateway {
  Future<List<Product>> find();
  Future<Product> create({
    required String name,
    required int price,
    required int stock,
  });
  Future<Product> findByUuid(String uuid);
  Future<void> deleteByUuid(String uuid);
  Future<Product> update(String uuid);
  Future<void> deleteAll();
}
