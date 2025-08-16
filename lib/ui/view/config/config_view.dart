import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:project_shelf/shared/constants.dart';

class ConfigView extends StatelessWidget {
  const ConfigView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Configuración', style: TEXT_GREEN_800.merge(FONT_BOLD)),
      ),
      body: Container(
        margin: EI_16,
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Row(
                  children: [
                    Text("Cargar Datos de Prueba"),
                    Spacer(),
                    FaIcon(FontAwesomeIcons.chevronRight),
                  ],
                ),
                onTap: () => context.go('/config/debug/load-data'),
              ),
            ),
            const SizedBox(height: H_8),
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
