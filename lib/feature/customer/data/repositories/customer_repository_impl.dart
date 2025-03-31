import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/feature/city/domain/entities/city_entity.dart';
import 'package:project_shelf/feature/customer/data/data_sources/customer_data_source.dart';
import 'package:project_shelf/feature/customer/domain/entities/customer_entity.dart';
import 'package:project_shelf/feature/customer/domain/repositories/customer_repository.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerDataSource _dataSource;

  CustomerRepositoryImpl(this._dataSource);

  @override
  Result<Stream<List<CustomerEntity>>, Error> find() {
    return _dataSource.find().map((stream) {
      return stream.map((list) {
        return list
            .map((data) => CustomerEntity(
                  uuid: data.customer.uuid!,
                  name: data.customer.name,
                  phone: data.customer.phone,
                  address: data.customer.address,
                  city: CityEntity(
                    id: data.city.id,
                    name: data.city.city,
                    department: data.city.department,
                  ),
                ))
            .toList();
      });
    });
  }

  @override
  Future<Result<CustomerEntity, Error>> findByUuid(String uuid) {
    return _dataSource.findByUuid(uuid).map((data) {
      return CustomerEntity(
        uuid: data.customer.uuid!,
        name: data.customer.name,
        phone: data.customer.phone,
        address: data.customer.address,
        city: CityEntity(
          id: data.city.id,
          name: data.city.city,
          department: data.city.department,
        ),
      );
    });
  }

  @override
  Future<Result<String, Error>> create(CustomerEntity entity) {
    return _dataSource.create(CustomerData(
      name: entity.name,
      phone: entity.phone,
      address: entity.address,
      city: entity.city.id,
    ));
  }

  @override
  Future<Result<Unit, Error>> delete(String uuid) {
    return _dataSource.delete(uuid);
  }

  @override
  Future<Result<Unit, Error>> update(CustomerEntity entity) {
    return _dataSource.update(CustomerData(
      name: entity.name,
      phone: entity.phone,
      address: entity.address,
      city: entity.city.id,
    ));
  }
}
