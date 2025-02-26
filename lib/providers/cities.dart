import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/providers/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "cities.g.dart";

@riverpod
class Cities extends _$Cities {
  @override
  Future<List<CityData>> build() async {
    final database = ref.watch(databaseProvider);
    return database.select(database.city).get();
  }

  Future<CityData> create(CityCompanion data) async {
    final database = ref.watch(databaseProvider);

    debugPrint("Creating city: $data");
    final city = await (database.into(database.city).insertReturning(data));
    debugPrint("City created: $data");

    await _invalidate();
    return city;
  }

  Future<Option<CityData>> findByRowId(int rowId) {
    final database = ref.watch(databaseProvider);
    return (database.select(database.city)..where((c) => c.rowId.equals(rowId)))
        .getSingleOrNull()
        .then((c) => Option.from(c));
  }

  Future<void> loadLocalData() async {
    debugPrint("Loading local cities data...");
    final database = ref.watch(databaseProvider);
    final input = await rootBundle.loadString("assets/departments_cities.csv");
    final fields = const CsvToListConverter().convert(input);

    // If cities found, don't load them.
    if (await database.managers.city.count() > 0) {
      debugPrint("Cities already loaded!");
      return;
    }

    debugPrint("Loading cities...");
    for (final entry in fields) {
      await (database
          .into(database.city)
          .insert(CityCompanion.insert(department: entry[0], city: entry[1])));
    }

    await _invalidate();
  }

  Future<void> _invalidate() async {
    // This will cause "build" on our notifier to asynchronously be called again,
    // and will notify listeners when doing so.
    ref.invalidateSelf();

    // (Optional) We can then wait for the new state to be computed.
    // This ensures "addTodo" does not complete until the new state is available.
    await future;
  }
}
