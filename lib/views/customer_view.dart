import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/providers/customers.dart';

final customerFuture = FutureProvider.autoDispose.family<CustomerData, String>(
    (ref, uuid) => ref.read(customersProvider.selectAsync((customers) =>
        customers.firstWhere((customer) => customer.uuid == uuid))));

class CustomerView extends ConsumerWidget {
  final String uuid;

  const CustomerView({required this.uuid, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customer = ref.watch(customerFuture(uuid));

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Editar Cliente")),
      body: SizedBox.expand(
        child: switch (customer) {
          AsyncData(:final value) => Text(value.name),
          AsyncError(:final error) => Text("error: $error"),
          _ => const Center(child: CircularProgressIndicator.adaptive()),
        },
      ),
    );
  }
}
