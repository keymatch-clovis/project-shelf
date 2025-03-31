import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/shared/presentation/widgets/text_fields/custom_text_field.dart';
import 'package:project_shelf/providers/preferences.dart';
import 'package:project_shelf/util/text_formatter.dart';

final editedPreferencesProvider =
    StateProvider.autoDispose<Map<PreferenceName, String>>((ref) {
  return {};
});

final canEditProvider = StateProvider.autoDispose<bool>((ref) {
  final editedPreferences = ref.watch(editedPreferencesProvider);
  final preferences = ref.watch(preferencesProvider);

  if (preferences.hasValue) {
    // If any key: value is different, we can edit.
    return editedPreferences.keys.any((key) {
      return editedPreferences[key] != preferences.value![key];
    });
  }
  return false;
});

class PreferencesView extends ConsumerWidget {
  const PreferencesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(preferencesProvider);
    final canEdit = ref.watch(canEditProvider);

    if (!preferences.hasValue) {
      return Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text("Preferencias")),
        body: Center(child: CircularProgressIndicator.adaptive()),
      );
    }

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Preferencias")),
      body: Container(
        margin: const EdgeInsets.all(18),
        child: Column(
          children: [
            CustomTextField(
              label: "Nombre de la Compañía",
              inputFormatters: [UpperCaseTextFormatter()],
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.characters,
              keyboardType: TextInputType.name,
              onChanged: (text) {
                ref
                    .read(editedPreferencesProvider.notifier)
                    .update((editedPreferences) {
                  editedPreferences[PreferenceName.COMPANY_NAME] = text;
                  return {...editedPreferences};
                });
              },
              initialValue: preferences.value![PreferenceName.COMPANY_NAME],
            ),
            CustomTextField(
              label: "Documento de la Compañía (e.g. NIT)",
              inputFormatters: [UpperCaseTextFormatter()],
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.characters,
              keyboardType: TextInputType.name,
              onChanged: (text) {
                ref
                    .read(editedPreferencesProvider.notifier)
                    .update((editedPreferences) {
                  editedPreferences[PreferenceName.COMPANY_DOCUMENT] = text;
                  return {...editedPreferences};
                });
              },
              initialValue: preferences.value![PreferenceName.COMPANY_DOCUMENT],
            ),
            CustomTextField(
              label: "Correo de la Compañía",
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              onChanged: (text) {
                ref
                    .read(editedPreferencesProvider.notifier)
                    .update((editedPreferences) {
                  editedPreferences[PreferenceName.COMPANY_EMAIL] = text;
                  return {...editedPreferences};
                });
              },
              initialValue: preferences.value![PreferenceName.COMPANY_EMAIL],
            ),
            CustomTextField(
              label: "Teléfono de la Compañía",
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.phone,
              onChanged: (text) {
                ref
                    .read(editedPreferencesProvider.notifier)
                    .update((editedPreferences) {
                  editedPreferences[PreferenceName.COMPANY_PHONE] = text;
                  return {...editedPreferences};
                });
              },
              initialValue: preferences.value![PreferenceName.COMPANY_PHONE],
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: canEdit,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              disabledElevation: 0,
              onPressed: () async {
                await ref
                    .read(preferencesProvider.notifier)
                    .setMap(ref.read(editedPreferencesProvider));
              },
              child: FaIcon(FontAwesomeIcons.floppyDisk),
            ),
          ],
        ),
      ),
    );
  }
}
