import 'package:flutter/foundation.dart';
import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/feature/city/domain/entities/city_entity.dart';
import 'package:project_shelf/feature/city/domain/repositories/city_repository.dart';

class GetCities {
  final CityRepository _repository;

  GetCities(this._repository);

  Result<Stream<List<CityEntity>>, Error> getCities() {
    debugPrint("Getting cities");
    return _repository.find();
  }
}
