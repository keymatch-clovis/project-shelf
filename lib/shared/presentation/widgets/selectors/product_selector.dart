import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/providers/product_search.dart';

class ProductSelector extends HookConsumerWidget {
  final Function(ProductData) onTap;

  const ProductSelector({super.key, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useSearchController();

    Widget renderList(List<ProductData> list) {
      if (list.isEmpty) {
        return ListTile(
          title: Text(
            "Sin productos",
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        );
      }

      return ListView.separated(
        // See more:
        // https://stackoverflow.com/questions/63639472/flutter-unexpected-space-at-the-top-of-listview
        padding: EdgeInsets.only(top: 0),
        separatorBuilder: (_, __) => Divider(),
        itemCount: list.length,
        itemBuilder: (_, index) => ListTile(
          title: Text(list[index].name),
          onTap: () {
            searchController.closeView(null);
            onTap(list[index]);
          },
        ),
      );
    }

    return SearchAnchor(
      searchController: searchController,
      builder: (contex, controller) => ElevatedButton.icon(
        label: FaIcon(FontAwesomeIcons.plus),
        onPressed: () => controller.openView(),
      ),
      suggestionsBuilder: (_, controller) {
        ref.read(productSearchProvider.notifier).setSearch(controller.text);
        return [];
      },
      viewBuilder: (_) => Consumer(
        builder: (_, ref, __) {
          return switch (ref.watch(productSearchProvider)) {
            AsyncData(:final value) => renderList(value),
            _ => Center(child: const CircularProgressIndicator.adaptive()),
          };
        },
      ),
    );
  }
}
