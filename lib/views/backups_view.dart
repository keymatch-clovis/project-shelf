import 'package:flutter/material.dart';
import "package:file_picker/file_picker.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/providers/backups.dart';
import 'package:project_shelf/providers/database.dart';

class BackupsView extends ConsumerWidget {
  const BackupsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final files = ref.watch(backupsProvider);

    Widget renderFiles() {
      return switch (files) {
        AsyncData(:final value) => _BackupList(value),
        AsyncError(:final error) => Text("error: $error"),
        _ => const Center(child: CircularProgressIndicator.adaptive()),
      };
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Copias de Seguridad'),
      ),
      body: Column(
        children: [
          Expanded(child: renderFiles()),
        ],
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        FloatingActionButton(
          heroTag: null,
          child: FaIcon(FontAwesomeIcons.fileImport),
          onPressed: () async {
            final backupFile = await FilePicker.platform
                .pickFiles(
                  dialogTitle: "Seleccionar archivo de datos",
                  allowMultiple: false,
                  withData: true,
                )
                .then((r) => Option.from(r));

            // NOTE: We can remove this later, this is just to be safe.
            await ref.read(backupsProvider.notifier).create();

            if (backupFile.isSome()) {
              ref
                  .read(databaseProvider.notifier)
                  .load(backupFile.unwrap().files.single.bytes!);
            }
          },
        ),
        const SizedBox(width: 12),
        FloatingActionButton(
          heroTag: null,
          child: FaIcon(FontAwesomeIcons.cloudArrowUp),
          onPressed: () => ref.read(backupsProvider.notifier).create(),
        ),
      ],
    );
  }
}

class _BackupList extends ConsumerWidget {
  final List<File> backups;

  const _BackupList(this.backups);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (backups.isEmpty) {
      return Center(child: Text("Sin copias de seguridad"));
    }

    return ListView.separated(
      itemCount: backups.length,
      itemBuilder: (context, index) => ListTile(
        title: _FileItem(
          file: backups[index],
          onLoad: ref.read(backupsProvider.notifier).load,
          onDelete: ref.read(backupsProvider.notifier).delete,
        ),
      ),
      separatorBuilder: (context, index) => Divider(),
    );
  }
}

class _FileItem extends StatelessWidget {
  final File file;
  final Function(String id) onLoad;
  final Function(String id) onDelete;

  const _FileItem({
    required this.file,
    required this.onLoad,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(file.name!),
            Text(
              Jiffy.parseFromDateTime(file.createdTime!).fromNow(),
              style: TextStyle(
                color: Theme.of(context).hintColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
        Spacer(),
        ElevatedButton.icon(
          onPressed: () => onLoad(file.id!),
          label: FaIcon(FontAwesomeIcons.cloudArrowDown),
        ),
        const SizedBox(width: 12),
        ElevatedButton.icon(
          onPressed: () => onDelete(file.id!),
          label: FaIcon(FontAwesomeIcons.trashCan),
        ),
      ],
    );
  }
}
