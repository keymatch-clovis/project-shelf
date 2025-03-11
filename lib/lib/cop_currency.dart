import 'package:intl/intl.dart';

class CopCurrency {
  final NumberFormat formatter;

  final String rawValue;
  final BigInt realValue;

  get formattedValue {
    return formatter.format(realValue / BigInt.from(100));
  }

  factory CopCurrency.fromString(String? value) {
    if (value != null) {
      return CopCurrency(value);
    }
    return CopCurrency.zero();
  }

  factory CopCurrency.fromCents(BigInt? cents) {
    if (cents != null) {
      return CopCurrency((cents ~/ BigInt.from(100)).toString());
    }
    return CopCurrency.zero();
  }

  factory CopCurrency.zero() {
    return CopCurrency("0");
  }

  CopCurrency(this.rawValue)
      : formatter = NumberFormat.currency(symbol: "", decimalDigits: 0),
        realValue = BigInt.parse(rawValue) * BigInt.from(100);

  @override
  String toString() {
    return formatter.format(realValue ~/ BigInt.from(100));
  }
}
