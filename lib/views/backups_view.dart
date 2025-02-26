import 'package:flutter/material.dart';
import "package:file_picker/file_picker.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
        AsyncData(:final value) => ListView.separated(
            itemCount: value.length,
            itemBuilder: (context, index) => ListTile(
              title: _FileItem(
                file: value[index],
                onLoad: ref.read(backupsProvider.notifier).load,
                onDelete: ref.read(backupsProvider.notifier).delete,
              ),
            ),
            separatorBuilder: (context, index) => Divider(),
          ),
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
          ElevatedButton.icon(
            onPressed: () => ref.read(backupsProvider.notifier).create(),
            label: FaIcon(FontAwesomeIcons.fax),
          ),
          ElevatedButton.icon(
            onPressed: () async {
              final backupFile = await FilePicker.platform
                  .pickFiles(
                    dialogTitle: "Seleccionar archivo de datos",
                    allowMultiple: false,
                    withData: true,
                  )
                  .then((r) => Option.from(r));

              if (backupFile.isSome()) {
                ref
                    .read(databaseProvider.notifier)
                    .load(backupFile.unwrap().files.single.bytes!);
              }
            },
            label: FaIcon(FontAwesomeIcons.atom),
          ),
        ],
      ),
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
        Text(file.name!),
        Spacer(),
        ElevatedButton.icon(
          onPressed: () => onLoad(file.id!),
          label: FaIcon(FontAwesomeIcons.sink),
        ),
        ElevatedButton.icon(
          onPressed: () => onDelete(file.id!),
          label: FaIcon(FontAwesomeIcons.trashCan),
        ),
      ],
    );
  }
}
