import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/shared/presentation/widgets/customer_search_anchor.dart';
import 'package:project_shelf/data/repository/customers_repository.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/providers/database.dart';

final customersProvider = FutureProvider((ref) async {
  return ref.watch(databaseProvider).getPopulatedCustomers().get();
});

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
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        CustomerSearchAnchor(
          builder: (context, controller) {
            return FloatingActionButton(
              heroTag: null,
              child: FaIcon(FontAwesomeIcons.magnifyingGlass),
              onPressed: () => controller.openView(),
            );
          },
          onTap: (customer) => context.go(
            "/customers/customer",
            extra: customer,
          ),
        ),
        const SizedBox(width: 12),
        FloatingActionButton(
          heroTag: null,
          onPressed: () => context.go('/customers/create'),
          child: FaIcon(FontAwesomeIcons.plus),
        ),
      ],
    );
  }
}

class _CustomerList extends ConsumerWidget {
  Widget renderList(List<GetPopulatedCustomersResult> list) {
    if (list.isEmpty) {
      return Center(child: Text("Sin clientes"));
    }

    return ListView.separated(
      itemCount: list.length,
      separatorBuilder: (_, __) => Divider(),
      itemBuilder: (context, index) => ListTile(
        title: _ListItem(list[index]),
        onTap: () => context.go(
          "/customers/customer",
          extra: list[index].toCustomerData(),
        ),
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
  final GetPopulatedCustomersResult data;

  const _ListItem(this.data);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.customer.name),
                if (data.customer.businessName != null) ...[
                  Text(
                    data.customer.businessName!,
                    style: TextStyle(
                        fontSize: 12, color: Theme.of(context).hintColor),
                  )
                ],
              ],
            ),
          ),
          Column(
            children: [
              Text(data.city.city),
              Text(data.city.department, style: TextStyle(fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }
}
