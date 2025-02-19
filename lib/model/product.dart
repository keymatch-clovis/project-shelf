import "dart:convert";
import "dart:typed_data";

import "package:freezed_annotation/freezed_annotation.dart";

part "product.freezed.dart";

// Required for JSON serialization.
part "product.g.dart";

@freezed
class Product with _$Product {
  // Added constructor. Must not have any parameter
  // https://pub.dev/packages/freezed#adding-getters-and-methods-to-our-models
  const Product._();

  const factory Product({
    required String name,
    required int value,
    required int stock,
    @Default("") String code,
  }) = _Product;

  factory Product.fromJson(Map<String, Object?> json) =>
      _$ProductFromJson(json);

  Uint8List toBytes() {
    return utf8.encode(json.encode(this.toJson()));
  }

  static Product fromBytes(Uint8List bytes) {
    return Product.fromJson(json.decode(utf8.decode(bytes)));
  }
}
