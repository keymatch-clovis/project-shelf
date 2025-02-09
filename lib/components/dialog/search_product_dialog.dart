import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/providers/product_search.dart';

class SearchProductDialog extends ConsumerWidget {
  const SearchProductDialog({super.key});

  Widget renderList(List<(String, ProductData)> list) {
    if (list.isEmpty) {
      return ListTile(title: const Text("No products found"));
    }

    return ListView.builder(
      // See more:
      // https://stackoverflow.com/questions/63639472/flutter-unexpected-space-at-the-top-of-listview
      padding: EdgeInsets.only(top: 0),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return switch (list[index].$1) {
          "code" => ListTile(
              title: Text("code: ${list[index].$2.code}"),
            ),
          _ => ListTile(
              title: Text(list[index].$2.name),
            ),
        };
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SearchAnchor(
          builder: (
            BuildContext context,
            SearchController controller,
          ) {
            return IconButton(
              icon: FaIcon(FontAwesomeIcons.plus),
              onPressed: () => controller.openView(),
            );
          },
          viewBuilder: (_) => Consumer(
            builder: (_, ref, __) {
              final foundProducts = ref.watch(searchProductsProvider);

              return switch (foundProducts) {
                AsyncData(:final value) => renderList(value),
                _ => Center(child: const CircularProgressIndicator.adaptive()),
              };
            },
          ),
          suggestionsBuilder: (context, controller) {
            ref.read(searchProvider.notifier).state = controller.value.text;
            return [];
          },
        ),
      ],
    );
  }
}
