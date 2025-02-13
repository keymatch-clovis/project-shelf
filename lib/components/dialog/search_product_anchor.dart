import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/providers/products.dart';

class SearchProductAnchor extends ConsumerStatefulWidget {
  final void Function(ProductData) onTap;

  const SearchProductAnchor({
    required this.onTap,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      SearchProductAnchorState();
}

class SearchProductAnchorState extends ConsumerState<SearchProductAnchor> {
  final controller = SearchController();

  var search = "";

  Widget renderList(List<ProductData> list) {
    var result = _search(list);
    return ListView.builder(
      // See more:
      // https://stackoverflow.com/questions/63639472/flutter-unexpected-space-at-the-top-of-listview
      padding: EdgeInsets.only(top: 0),
      itemCount: result.length,
      itemBuilder: (_, index) {
        return ListTile(
          title: Text(result[index].name),
          onTap: () {
            controller.closeView(result[index].name);
            widget.onTap(result[index]);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      searchController: controller,
      builder: (context, controller) => IconButton(
        onPressed: controller.openView,
        icon: FaIcon(FontAwesomeIcons.plus),
      ),
      suggestionsBuilder: (context, controller) {
        setState(() {
          search = controller.value.text;
        });
        return [];
      },
      viewBuilder: (_) => Consumer(
        builder: (_, ref, __) {
          return switch (ref.watch(productsProvider)) {
            AsyncData(:final value) => renderList(value),
            _ => Center(child: const CircularProgressIndicator.adaptive()),
          };
        },
      ),
    );
  }

  List<ProductData> _search(List<ProductData> products) {
    // If no search, return all the products.
    if (search.isEmpty) {
      return products;
    }

    final foundByName = extractAllSorted(
      query: search.toLowerCase(),
      choices: products,
      getter: (product) => product.name,
    );

    final result = [
      ...foundByName,
    ];
    result.sort((a, b) => b.score.compareTo(a.score));

    return result.toList().map((e) => e.choice).toList();
  }
}
