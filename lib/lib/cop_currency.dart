import 'package:intl/intl.dart';

class CopCurrency {
  final NumberFormat formatter;

  final double rawValue;
  final int realValue;

  get formattedValue {
    return formatter.format(realValue / 100);
  }

  static fromCents(BigInt cents) {
    return CopCurrency(cents / BigInt.from(100));
  }

  CopCurrency(this.rawValue)
      : formatter = NumberFormat.currency(symbol: "\$"),
        realValue = (rawValue * 100).round();

  @override
  String toString() {
    return formatter.format(realValue / 100);
  }
}
