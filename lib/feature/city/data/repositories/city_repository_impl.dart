import 'package:drift/drift.dart';
import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/feature/city/data/data_sources/city_data_source.dart';
import 'package:project_shelf/feature/city/domain/entities/city_entity.dart';
import 'package:project_shelf/feature/city/domain/repositories/city_repository.dart';

class CityRepositoryImpl implements CityRepository {
  final CityDataSource _dataSource;

  CityRepositoryImpl(this._dataSource);

  @override
  Future<Result<int, Error>> create({
    required String name,
    required String department,
  }) {
    return _dataSource.create(CityCompanion(
      name: Value(name),
      department: Value(department),
    ));
  }

  @override
  Result<Stream<List<CityEntity>>, Error> find() {
    return _dataSource.find().map((stream) {
      return stream.map((list) {
        return list
            .map((data) => CityEntity(
                  id: data.id,
                  name: data.name,
                  department: data.department,
                ))
            .toList();
      });
    });
  }
}
