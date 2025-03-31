import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class ConfigurationView extends ConsumerWidget {
  final String? restorationId;

  const ConfigurationView({this.restorationId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      restorationId: restorationId,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Configuración'),
      ),
      body: Container(
        margin: const EdgeInsets.all(18),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Row(
                  children: [
                    Text("Copias de Seguridad"),
                    Spacer(),
                    FaIcon(FontAwesomeIcons.chevronRight),
                  ],
                ),
                onTap: () => context.go('/configuration/backup'),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                title: Row(
                  children: [
                    FaIcon(size: 18, FontAwesomeIcons.fileImport),
                    const SizedBox(width: 12),
                    Text("Cargar Datos"),
                    Spacer(),
                    FaIcon(FontAwesomeIcons.chevronRight),
                  ],
                ),
                onTap: () => context.go('/settings/data-load'),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                title: Row(
                  children: [
                    Text("Preferencias"),
                    Spacer(),
                    FaIcon(FontAwesomeIcons.chevronRight),
                  ],
                ),
                onTap: () => context.go('/settings/preferences'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
