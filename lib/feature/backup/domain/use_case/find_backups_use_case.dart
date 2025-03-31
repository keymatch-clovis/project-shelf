import 'package:googleapis/drive/v3.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/feature/backup/data/provider/google_drive_data_source_provider.dart';
import 'package:project_shelf/feature/backup/data/repository/backup_repository_impl.dart';

class FindBackupsUseCase {
  final Ref ref;

  FindBackupsUseCase(this.ref);

  Future<Result<List<File>, Error>> handle() async {
    final googleDriveDataSource = ref.watch(googleDriveDataSourceProvider);
    final repository = BackupRepositoryImpl(googleDriveDataSource);

    return repository.getBackups();
  }
}
