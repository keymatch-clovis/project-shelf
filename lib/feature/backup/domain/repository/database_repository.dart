import 'dart:typed_data';

import 'package:oxidized/oxidized.dart';

abstract class DatabaseRepository {
  Result<Uint8List, Error> exportDatabase();
  Future<Result<Unit, Error>> loadDatabase(Uint8List bytes);
}
