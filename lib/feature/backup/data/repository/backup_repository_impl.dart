import 'dart:typed_data';

import 'package:async/async.dart' as async;
import 'package:googleapis/drive/v3.dart';
import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/feature/backup/data/data_source/google_drive_data_source.dart';
import 'package:project_shelf/feature/backup/domain/repository/backup_repository.dart';

class BackupRepositoryImpl implements BackupRepository {
  final GoogleDriveDataSource _dataSource;

  BackupRepositoryImpl(this._dataSource);

  @override
  Future<Result<Uint8List, Error>> downloadBackup(String fileId) async {
    return _dataSource
        .getDriveApi()
        .andThenAsync((api) => Result.asyncOf(() async {
              print("Downloading file: $fileId");
              final media = await api.files.get(
                fileId,
                downloadOptions: DownloadOptions.fullMedia,
              ) as Media;

              return async.collectBytes(media.stream);
            }));
  }

  @override
  Future<Result<List<File>, Error>> getBackups() {
    return _dataSource
        .getDriveApi()
        .andThenAsync((api) => Result.asyncOf(() async {
              print("Getting backups");
              //  > To search for files in the application data folder, set the spaces
              //  > field to appDataFolder and use the files.list method.
              // See more: https://developers.google.com/drive/api/guides/appdata#search-files
              return await api.files
                  .list(spaces: "appDataFolder", $fields: "*")
                  .then((list) => list.files ?? []);
            }));
  }
}
