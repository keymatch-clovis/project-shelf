import 'package:intl/intl.dart';

class CopCurrency {
  final NumberFormat formatter;

  final double rawValue;
  final int realValue;

  get formattedValue {
    return formatter.format(realValue / 100);
  }

  static fromCents(int cents) {
    return CopCurrency(cents / 100.0);
  }

  CopCurrency(this.rawValue)
      : formatter = NumberFormat.currency(symbol: "\$"),
        realValue = (rawValue * 100).round();
}
