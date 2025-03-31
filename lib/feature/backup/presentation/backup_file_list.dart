import 'package:flutter/material.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/feature/backup/domain/use_case/find_backups_use_case.dart';

final backupsProvider = FutureProvider((ref) {
  return FindBackupsUseCase(ref).handle();
});

class BackupFileList extends ConsumerWidget {
  final Function(File) onTap;

  const BackupFileList({required this.onTap, super.key,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget render(Result<List<File>, Error> backups) {
      return backups.when(
        err: (err) => Text("error: $err"),
        ok: (list) {
          if (list.isEmpty) {
            return Center(child: Text("Sin copias de seguridad"));
          }

          return ListView.separated(
            itemCount: list.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(list[index].name ?? ""),
              onTap: () => onTap(list[index]),
            ),
            separatorBuilder: (context, index) => Divider(),
          );
        },
      );
    }

    return switch (ref.watch(backupsProvider)) {
      AsyncData(:final value) => render(value),
      AsyncError(:final error) => Text("error: $error"),
      _ => const Center(child: CircularProgressIndicator.adaptive()),
    };
  }
}
