import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/feature/city/data/data_sources/city_data_source.dart';

class CityDataSourceImpl implements CityDataSource {
  final ShelfDatabase _database;

  CityDataSourceImpl(this._database);

  @override
  Future<Result<int, Error>> create(CityCompanion data) {
    return Result.asyncOf(() {
      return _database.insertCity(data.name.value, data.department.value);
    });
  }

  @override
  Result<Stream<List<CityData>>, Error> find() {
    return Result.of(_database.getCities().watch);
  }

  @override
  Future<Result<CityData, Error>> findById(int id) {

    return Result.asyncOf(() {
      return _database.getCityById(id).getSingle();
    });
  }
}
