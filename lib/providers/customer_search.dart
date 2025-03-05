import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:project_shelf/providers/customers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "customer_search.g.dart";

@riverpod
class CustomerSearch extends _$CustomerSearch {
  @override
  FutureOr<List<CustomerWithCity>> build() {
    return _search("");
  }

  Future<void> setSearch(String search) async {
    state = AsyncData(await _search(search));
  }

  Future<List<CustomerWithCity>> _search(String search) async {
    final customers = await ref.watch(customersProvider.future);
    if (search.isEmpty) {
      return customers;
    }

    final foundByName = extractAllSorted(
      query: search,
      choices: customers,
      getter: (data) => data.customer.name,
    );

    final result = [
      ...foundByName,
    ];
    result.sort((a, b) => b.score.compareTo(a.score));

    return result.toList().map((e) => e.choice).toList();
  }
}
