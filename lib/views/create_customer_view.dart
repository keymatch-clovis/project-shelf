import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/components/forms/create_client_form.dart';

class CreateCustomerView extends ConsumerWidget {
  final String? restorationId;

  const CreateCustomerView({this.restorationId, super.key});

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
          onSubmit: (data) => {},
        ),
      ),
    );
  }
}
