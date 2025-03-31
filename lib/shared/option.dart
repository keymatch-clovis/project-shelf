import 'package:oxidized/oxidized.dart';

extension OptionIterable<T> on Iterable<T> {
  Option<T> firstWhereOption(bool Function(T el) test) {
    final list = where(test);
    return list.isEmpty ? Option.none() : Option.some(list.first);
  }
}
