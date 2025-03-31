import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/feature/city/domain/entities/city_entity.dart';

// NOTE: I understand this entity is the union between the data layer, and the
// domain layer. As such, I have to imagine what a customer might look like in
// the app. With all its properties.
class CustomerEntity {
  final String uuid;
  final String name;
  final String phone;
  final String address;
  final Option<String> businessName;
  final CityEntity city;

  CustomerEntity({
    required this.uuid,
    required this.name,
    required this.phone,
    required this.address,
    this.businessName = const Option.none(),
    required this.city,
  });
}
