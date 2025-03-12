import "dart:io";

import "package:async/async.dart";
import "package:device_info_plus/device_info_plus.dart";
import "package:flutter/foundation.dart";
import "package:oxidized/oxidized.dart";
import "package:path/path.dart";
import "package:path_provider/path_provider.dart";
import "package:project_shelf/providers/database.dart";
import "package:project_shelf/providers/google_drive.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:googleapis/drive/v3.dart" as drive;

part "backups.g.dart";

@riverpod
class Backups extends _$Backups {
  @override
  Future<List<drive.File>> build() async {
    return _find();
  }

  Future<void> load(String fileId) async {
    // NOTE: We can remove this later, this is just to be safe.
    await this.create();

    final driveApi =
        await ref.watch(googleDriveProvider.notifier).getDriveApi();

    debugPrint("Downloading database file with ID: $fileId");
    drive.Media media = await driveApi.files.get(
      fileId,
      downloadOptions: drive.DownloadOptions.fullMedia,
    ) as drive.Media;

    Uint8List bytes = await collectBytes(media.stream);

    debugPrint("File downloaded: $fileId");

    debugPrint("Loading database...");
    await ref.watch(databaseProvider.notifier).load(bytes);
    debugPrint("Database lodaded!");
  }

  Future<void> delete(String id) async {
    final driveApi =
        await ref.watch(googleDriveProvider.notifier).getDriveApi();

    debugPrint("Deleting file with ID: $id");
    await driveApi.files.delete(id);
    debugPrint("File deleted: $id");

    await _invalidate();
  }

  Future<void> create() async {
    final database = ref.watch(databaseProvider);
    final driveApi =
        await ref.watch(googleDriveProvider.notifier).getDriveApi();

    final tempDir = await getTemporaryDirectory();
    final backupName = await _generateBackupFileName();
    final backupPath = join(tempDir.path, "$backupName.sqlite");
    final backupFile = File(backupPath);

    // Override an existing backup, sqlite expects the target file to be empty.
    if (backupFile.existsSync()) {
      backupFile.deleteSync();
    }

    debugPrint("Saving local database into cache: $backupPath");
    await database.customStatement("VACUUM INTO ?", [backupPath]);
    debugPrint("Local database saved into cache: $backupPath");

    //  > To create a file in the application data folder, specify `appDataFolder`
    //  > in the `parents` property of the file [...].
    // See more: https://developers.google.com/drive/api/guides/appdata
    final file = drive.File(parents: ["appDataFolder"]);
    file.name = backupName;
    file.createdTime = DateTime.now();

    debugPrint("Saving database into Drive...");
    await driveApi.files.create(
      file,
      uploadMedia: drive.Media(
        backupFile.openRead(),
        backupFile.lengthSync(),
      ),
    );
    debugPrint("Backup saved!");

    debugPrint("Deleting local database cache file...");
    await backupFile.delete();
    debugPrint("Local database file deleted.");

    await _invalidate();
  }

  Future<List<drive.File>> _find() async {
    final driveApi =
        await ref.watch(googleDriveProvider.notifier).getDriveApi();

    debugPrint("Getting backups...");
    //  > To search for files in the application data folder, set the spaces
    //  > field to appDataFolder and use the files.list method.
    // See more: https://developers.google.com/drive/api/guides/appdata#search-files
    final backups = await driveApi.files
        .list(spaces: "appDataFolder", $fields: "*")
        .then((list) => Option.from(list.files));
    debugPrint("Got backups: $backups");

    return backups.unwrapOr([]);
  }

  Future<String> _generateBackupFileName() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    final allInfo = deviceInfo.data;
    final database = ref.read(databaseProvider);

    final backupName = "db-v${database.schemaVersion}-${allInfo['product']}";
    return backupName;
  }

  Future<void> _invalidate() async {
    // This will cause "build" on our notifier to asynchronously be called again,
    // and will notify listeners when doing so.
    ref.invalidateSelf();

    // (Optional) We can then wait for the new state to be computed.
    // This ensures "addTodo" does not complete until the new state is available.
    await future;
  }
}
