import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/providers/customers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "customer_search.g.dart";

@riverpod
class CustomerSearch extends _$CustomerSearch {
  @override
  FutureOr<List<CustomerData>> build() {
    return _search("");
  }

  Future<void> setSearch(String search) async {
    state = AsyncData(await _search(search));
  }

  Future<List<CustomerData>> _search(String search) async {
    final customers = await ref.watch(customersProvider.future);
    if (search.isEmpty) {
      return customers;
    }

    final foundByName = extractAllSorted(
      query: search,
      choices: customers,
      getter: (customer) => customer.name,
    );

    final result = [
      ...foundByName,
    ];
    result.sort((a, b) => b.score.compareTo(a.score));

    return result.toList().map((e) => e.choice).toList();
  }
}
