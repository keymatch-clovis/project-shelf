import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/feature/backup/data/provider/google_drive_data_source_provider.dart';
import 'package:project_shelf/feature/backup/data/repository/backup_repository_impl.dart';
import 'package:project_shelf/feature/backup/data/repository/database_repository_impl.dart';

class LoadBackupUseCase {
  final WidgetRef ref;

  LoadBackupUseCase(this.ref);

  void handle(String fileId) async {
    final googleDriveDataSource = ref.watch(googleDriveDataSourceProvider);
    final databaseDataSource = ref.watch(databaseProvider);
    final googleDriveRepository = BackupRepositoryImpl(googleDriveDataSource);
    final databaseRepository = DatabaseRepositoryImpl(databaseDataSource);

    await googleDriveRepository
        .downloadBackup(fileId)
        .map((bytes) => databaseRepository.loadDatabase(bytes));
  }
}
