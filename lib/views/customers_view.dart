import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/providers/customers.dart';

class CustomersView extends ConsumerWidget {
  final String? restorationId;

  const CustomersView({this.restorationId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      restorationId: restorationId,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Clientes'),
      ),
      body: _CustomerList(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: null,
            onPressed: () {},
            child: FaIcon(FontAwesomeIcons.magnifyingGlass),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: null,
            onPressed: () => context.go('/customers/create'),
            child: FaIcon(FontAwesomeIcons.plus),
          ),
        ],
      ),
    );
  }
}

class _CustomerList extends ConsumerWidget {
  Widget renderList(List<CustomerData> list) {
    if (list.isEmpty) {
      return Center(child: Text("Sin clientes"));
    }

    return ListView.separated(
      padding: EdgeInsets.all(0),
      itemCount: list.length,
      separatorBuilder: (_, __) => Divider(),
      itemBuilder: (context, index) => ListTile(
        title: _ListItem(list[index]),
        onTap: () => context.go("/customers/customer", extra: list[index]),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customers = ref.watch(customersProvider);

    return switch (customers) {
      AsyncData(:final value) => renderList(value),
      AsyncError(:final error) => Text("error: $error"),
      _ => const Center(child: CircularProgressIndicator.adaptive()),
    };
  }
}

class _ListItem extends StatelessWidget {
  final CustomerData data;

  const _ListItem(this.data);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.name),
        ],
      ),
    );
  }
}
