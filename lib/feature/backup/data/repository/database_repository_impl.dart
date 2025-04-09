import 'dart:io';
import 'dart:typed_data';

import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/feature/backup/domain/repository/database_repository.dart';
import 'package:project_shelf/shared/data/data_source/sqlite/sqlite_data_source.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  final DatabaseDataSource _dataSource;

  DatabaseRepositoryImpl(this._dataSource);

  @override
  Result<Uint8List, Error> exportDatabase() {
    return _dataSource.databasePath.when(
      some: (path) {
        return Result.ok(File(path).readAsBytesSync());
      },
      none: () => Result.err(Error()),
    );
  }

  @override
  Future<Result<Unit, Error>> loadDatabase(Uint8List bytes) async {
    await _dataSource.open(bytes: Option.some(bytes));
    return Result.ok(Unit.unit);
  }
}
