import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/components/lists/client_list.dart';
import 'package:project_shelf/providers/clients.dart';

class ClientsView extends ConsumerWidget {
  final String? restorationId;

  const ClientsView({this.restorationId, super.key});

  Widget renderClientList(BuildContext context, WidgetRef ref) {
    final asyncList = ref.watch(clientsProvider);

    return switch (asyncList) {
      AsyncData(value: final list) => ClientList(
          list: list,
          onTap: (id) => context.go('/clients/client/$id'),
        ),
      _ => Center(child: const CircularProgressIndicator.adaptive()),
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      restorationId: restorationId,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Clientes'),
      ),
      body: SizedBox.expand(child: renderClientList(context, ref)),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => context.go('/clients/create'),
            child: Icon(Icons.add),
          ),
          SizedBox.square(
            dimension: 10,
          ),
        ],
      ),
    );
  }
}
