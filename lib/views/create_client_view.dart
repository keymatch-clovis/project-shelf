import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/components/forms/create_client_form.dart';
import 'package:project_shelf/lib/form_entry.dart';
import 'package:project_shelf/providers/clients.dart';

class CreateClientView extends ConsumerWidget {
  final String? restorationId;

  const CreateClientView({this.restorationId, super.key});

  createClient(
    BuildContext context,
    WidgetRef ref,
    Map<String, FormEntry> data,
  ) {
    ref.read(clientsProvider.notifier).add(
          data.map((key, value) => MapEntry(key, value.value)),
        );
    context.go('/clients');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RestorationScope(
      restorationId: restorationId,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Crear Cliente'),
        ),
        body: CreateClientForm(
          restorationId: 'create.client.form',
          onSubmit: (data) => createClient(context, ref, data),
        ),
      ),
    );
  }
}
