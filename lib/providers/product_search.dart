import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/providers/product/products.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "product_search.g.dart";

@riverpod
class ProductSearch extends _$ProductSearch {
  @override
  FutureOr<List<ProductData>> build() async {
    return await _search("");
  }

  Future<void> setSearch(String search) async {
    state = AsyncData(await _search(search));
  }

  Future<List<ProductData>> _search(String search) async {
    final products = await ref.watch(productsProvider.future);
    if (search.isEmpty) {
      return products;
    }

    final foundByName = extractAllSorted(
      query: search,
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
