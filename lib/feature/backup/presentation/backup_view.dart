import 'package:flutter/material.dart';
import "package:file_picker/file_picker.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/feature/backup/domain/use_case/export_backup_use_case.dart';
import 'package:project_shelf/feature/backup/domain/use_case/load_backup_use_case.dart';
import 'package:project_shelf/feature/backup/presentation/backup_file_list.dart';

class BackupView extends ConsumerWidget {
  const BackupView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Copias de Seguridad'),
      ),
      body: Column(
        children: [
          Expanded(
            child: BackupFileList(
              onTap: (file) => LoadBackupUseCase(ref).handle(file.id!),
            ),
          ),
        ],
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        FloatingActionButton(
          heroTag: null,
          child: FaIcon(FontAwesomeIcons.fileExport),
          onPressed: () async => await ExportBackupUseCase(ref).handle(),
        ),
        const SizedBox(width: 12),
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
          },
        ),
        const SizedBox(width: 12),
        FloatingActionButton(
          heroTag: null,
          child: FaIcon(FontAwesomeIcons.cloudArrowUp),
          onPressed: () => {},
        ),
      ],
    );
  }
}
