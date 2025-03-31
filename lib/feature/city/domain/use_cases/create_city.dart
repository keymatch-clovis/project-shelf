import 'package:flutter/material.dart';
import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/feature/city/domain/repositories/city_repository.dart';

class CreateCity {
  final CityRepository _repository;

  CreateCity(this._repository);

  Result<Unit, Error> createCity() {
    debugPrint("Loading local cities data");
    _repository.create(name: "", department: "");

    return Result.ok(Unit.unit);
  }
}
