import 'dart:async';

class DebugLoadDataViewModel {
  final FutureOr<void> Function() seedProducts;
  final FutureOr<void> Function() deleteAllProducts;

  DebugLoadDataViewModel({
    required this.seedProducts,
    required this.deleteAllProducts,
  });
}
