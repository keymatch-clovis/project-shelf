import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/providers/cities.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "city_search.g.dart";

@riverpod
class CitySearch extends _$CitySearch {
  @override
  FutureOr<List<CityData>> build() async {
    return await _search("");
  }

  Future<void> setSearch(String search) async {
    state = AsyncData(await _search(search));
  }

  Future<List<CityData>> _search(String search) async {
    final cities = await ref.watch(citiesProvider.future);
    if (search.isEmpty) {
      return cities;
    }

    final foundByCity = extractAllSorted(
      query: search,
      choices: cities,
      getter: (city) => city.city,
    );

    final result = [
      ...foundByCity,
    ];
    result.sort((a, b) => b.score.compareTo(a.score));

    return result.toList().map((e) => e.choice).toList();
  }
}
