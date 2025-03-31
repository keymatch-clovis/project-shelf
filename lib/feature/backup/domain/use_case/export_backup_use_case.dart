import 'package:file_picker/file_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/feature/backup/data/repository/database_repository_impl.dart';
import 'package:project_shelf/shared/data/provider/database_provider.dart';


class ExportBackupUseCase {
  final WidgetRef ref;

  ExportBackupUseCase(this.ref);

  Future<void> handle() async {
    final databaseDataSource = ref.watch(databaseProvider);
    final databaseRepository = DatabaseRepositoryImpl(databaseDataSource);

    await databaseRepository.exportDatabase().mapAsync(
      (bytes) {
        return FilePicker.platform.saveFile(bytes: bytes);
      },
    );
  }
}
