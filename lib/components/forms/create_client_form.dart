import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateClientForm extends ConsumerWidget {
  final String? restorationId;
  final void Function(Map<String, String>) onSubmit;

  const CreateClientForm({
    required this.onSubmit,
    this.restorationId,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
