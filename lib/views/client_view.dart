import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/database/database.dart';

class ClientView extends ConsumerWidget {
  final String id;

  const ClientView({required this.id, super.key});

  Widget renderClient(BuildContext context, WidgetRef ref) {
    final asyncClient = ref.watch(databaseProvider).getProduct(id);
    return switch (asyncClient) {
      AsyncData(:final value) => Text(value.id),
      _ => Center(child: const CircularProgressIndicator.adaptive())
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('aoeu')),
      body: SizedBox.expand(
        child: renderClient(context, ref),
      ),
    );
  }
}
