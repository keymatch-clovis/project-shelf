import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/providers/customer_search.dart';

class CustomerSearchAnchor extends HookConsumerWidget {
  final Function(CustomerData)? onTap;
  final Widget Function(BuildContext, SearchController) builder;

  const CustomerSearchAnchor({
    super.key,
    required this.builder,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useSearchController();

    Widget renderList(List<CustomerData> list) {
      return ListView.separated(
        // See more:
        // https://stackoverflow.com/questions/63639472/flutter-unexpected-space-at-the-top-of-listview
        padding: EdgeInsets.only(top: 0),
        separatorBuilder: (_, __) => Divider(),
        itemCount: list.length,
        itemBuilder: (_, index) => ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(list[index].name),
            ],
          ),
          onTap: () {
            controller.closeView(null);
            onTap!(list[index]);
          },
        ),
      );
    }

    return SearchAnchor(
      searchController: controller,
      builder: builder,
      suggestionsBuilder: (_, controller) {
        ref.read(customerSearchProvider.notifier).setSearch(controller.text);
        return [];
      },
      viewBuilder: (_) => Consumer(
        builder: (_, ref, __) {
          return switch (ref.watch(customerSearchProvider)) {
            AsyncData(:final value) => renderList(
                value.map((v) => v.customer).toList(),
              ),
            _ => Center(child: const CircularProgressIndicator.adaptive()),
          };
        },
      ),
    );
  }
}
