import 'dart:isolate';

import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/providers/products.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_search.g.dart';

const searchRatioThreshold = 80;

final searchProvider = StateProvider((ref) => "");

@riverpod
FutureOr<List<(String, ProductData)>> searchProducts(Ref ref) async {
  print("executing isolate");
  final search = ref.watch(searchProvider);
  final products = ref.watch(productsProvider);

  return await Isolate.run(() {
    print("current search: $search");

    // If no search, return all the products.
    if (search.isEmpty) {
      return products.value!.map((product) => ("name", product)).toList();
    }

    final foundByName = extractAllSorted(
      query: search.toLowerCase(),
      choices: products.value!,
      getter: (product) => product.name,
    );

    final foundByCode = extractAllSorted(
      query: search.toLowerCase(),
      // We have to sort out the null values.
      choices:
          products.value!.where((product) => product.code != null).toList(),
      getter: (product) => product.code!,
    );

    final result = [
      ...foundByName.map((found) => ("name", found)),
      ...foundByCode.map((found) => ("code", found)),
    ];
    result.sort((a, b) => b.$2.score.compareTo(a.$2.score));

    return result.map((r) => (r.$1, r.$2.choice)).toList();
  });
}
