import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/feature/city/domain/entities/city_entity.dart';

abstract class CityRepository {
  Result<Stream<List<CityEntity>>, Error> find();
  Future<Result<int, Error>> create({
    required String name,
    required String department,
  });
}
