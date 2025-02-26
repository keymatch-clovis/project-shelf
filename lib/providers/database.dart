import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:oxidized/oxidized.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_shelf/database/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:uuid/uuid.dart';

part 'database.g.dart';

@riverpod
class Database extends _$Database {
  @override
  ShelfDatabase build() {
    // If running tests.
    if (Platform.environment.containsKey("FLUTTER_TEST")) {
      return ShelfDatabase.withExecutor(DatabaseConnection(
        NativeDatabase.memory(),
        closeStreamsSynchronously: true,
      ));
    }

    return ShelfDatabase();
  }

  Future<void> load(Uint8List bytes) async {
    if (await _checkData(bytes)) {
      // Close the current database, and create another one.
      await state.close();
      state = ShelfDatabase(bytes: Option.some(bytes));

      ref.notifyListeners();
    }
  }

  Future<bool> _checkData(Uint8List bytes) async {
    // For the data check, we need to create two files -- One for the storage
    // of the bytes to check, and other for the sqlite database created.

    debugPrint("Loading bytes: ${bytes.length}");
    final tempDir = await getTemporaryDirectory();
    final rawFilePath = join(tempDir.path, Uuid().v4());
    final tempDbPath = join(tempDir.path, Uuid().v4());

    final rawFile = File(rawFilePath);
    // Write the bytes to the raw file.
    rawFile.writeAsBytesSync(bytes);

    try {
      // Open the file with the raw bytes to check.
      final backupDb = sqlite3.open(rawFilePath);

      debugPrint("Testing the data is healthy...");
      // Vacuum it into a temporary location first to make sure it's working.
      backupDb
        ..execute("VACUUM INTO ?", [tempDbPath])
        ..dispose();
    } catch (e) {
      debugPrint(e.toString());
      return false;
    } finally {
      debugPrint("Deleting temporal files...");
      await rawFile.delete();

      final tempDb = File(tempDbPath);
      if (tempDb.existsSync()) {
        await File(tempDbPath).delete();
      }
    }

    return true;
  }
}
