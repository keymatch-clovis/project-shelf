import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:oxidized/oxidized.dart';

class StringOptionConverter implements JsonConverter<Option<String>, String?> {
  const StringOptionConverter();

  @override
  Option<String> fromJson(String? json) {
    return Option.from(json);
  }

  @override
  String? toJson(Option<String> object) {
    return object.isSome() ? object.unwrap() : null;
  }
}

class IntOptionConverter implements JsonConverter<Option<int>, int?> {
  const IntOptionConverter();

  @override
  Option<int> fromJson(int? json) {
    return Option.from(json);
  }

  @override
  int? toJson(Option<int> object) {
    return object.isSome() ? object.unwrap() : null;
  }
}
