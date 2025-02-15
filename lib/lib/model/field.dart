import "package:oxidized/oxidized.dart";

class Field {
  String value;
  Option<String> error;

  Field({
    String? value,
    this.error = const Option.none(),
  }) : value = value ?? "";

  factory Field.empty() => Field(value: "");
}
