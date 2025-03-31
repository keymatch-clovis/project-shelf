import 'dart:typed_data';

import 'package:googleapis/drive/v3.dart';
import 'package:oxidized/oxidized.dart';

abstract class BackupRepository {
  Future<Result<Uint8List, Error>> downloadBackup(String fileId);
  Future<Result<List<File>, Error>> getBackups();
}
