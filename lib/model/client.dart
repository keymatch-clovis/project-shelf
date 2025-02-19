import "dart:convert";
import "dart:typed_data";

import "package:freezed_annotation/freezed_annotation.dart";

part "client.freezed.dart";

// Required for JSON serialization.
part "client.g.dart";

@freezed
class Client with _$Client {
  // Added constructor. Must not have any parameter
  // https://pub.dev/packages/freezed#adding-getters-and-methods-to-our-models
  const Client._();

  const factory Client({
    required String name,
    required String businessName,
    required String address,
    required String phone,
  }) = _Client;

  factory Client.fromJson(Map<String, Object?> json) => _$ClientFromJson(json);

  Uint8List toBytes() {
    return utf8.encode(json.encode(this.toJson()));
  }

  static Client fromBytes(Uint8List bytes) {
    return Client.fromJson(json.decode(utf8.decode(bytes)));
  }
}
