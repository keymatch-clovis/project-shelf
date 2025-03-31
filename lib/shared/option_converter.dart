import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:oxidized/oxidized.dart';

class OptionConverter<T> extends JsonConverter<Option, T> {
  const OptionConverter();

  @override
  Option fromJson(T json) {
    return Option.from(json);
  }

  @override
  T toJson(Option object) {
    return object.unwrapOr(null);
  }
}
