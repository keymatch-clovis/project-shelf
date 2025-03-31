import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/feature/backup/data/data_source/google_drive_data_source.dart';

final googleDriveDataSourceProvider = Provider.autoDispose((ref) {
  // NOTE: We want to keep this provider alive for as long as possible, as the
  // account that the data source references might be useful at all times.
  ref.keepAlive();
  return GoogleDriveDataSource();
});
