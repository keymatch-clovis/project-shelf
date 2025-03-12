// dart format width=80
// GENERATED CODE, DO NOT EDIT BY HAND.
// ignore_for_file: type=lint
import 'package:drift/drift.dart';

class City extends Table with TableInfo<City, CityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  City(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> rowId = GeneratedColumn<int>(
      'row_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
      'city', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  late final GeneratedColumn<String> department = GeneratedColumn<String>(
      'department', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [rowId, city, department];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'city';
  @override
  Set<GeneratedColumn> get $primaryKey => {rowId};
  @override
  CityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CityData(
      rowId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}row_id'])!,
      city: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}city'])!,
      department: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}department'])!,
    );
  }

  @override
  City createAlias(String alias) {
    return City(attachedDatabase, alias);
  }
}

class CityData extends DataClass implements Insertable<CityData> {
  final int rowId;
  final String city;
  final String department;
  const CityData(
      {required this.rowId, required this.city, required this.department});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['row_id'] = Variable<int>(rowId);
    map['city'] = Variable<String>(city);
    map['department'] = Variable<String>(department);
    return map;
  }

  CityCompanion toCompanion(bool nullToAbsent) {
    return CityCompanion(
      rowId: Value(rowId),
      city: Value(city),
      department: Value(department),
    );
  }

  factory CityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CityData(
      rowId: serializer.fromJson<int>(json['rowId']),
      city: serializer.fromJson<String>(json['city']),
      department: serializer.fromJson<String>(json['department']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'rowId': serializer.toJson<int>(rowId),
      'city': serializer.toJson<String>(city),
      'department': serializer.toJson<String>(department),
    };
  }

  CityData copyWith({int? rowId, String? city, String? department}) => CityData(
        rowId: rowId ?? this.rowId,
        city: city ?? this.city,
        department: department ?? this.department,
      );
  CityData copyWithCompanion(CityCompanion data) {
    return CityData(
      rowId: data.rowId.present ? data.rowId.value : this.rowId,
      city: data.city.present ? data.city.value : this.city,
      department:
          data.department.present ? data.department.value : this.department,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CityData(')
          ..write('rowId: $rowId, ')
          ..write('city: $city, ')
          ..write('department: $department')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(rowId, city, department);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CityData &&
          other.rowId == this.rowId &&
          other.city == this.city &&
          other.department == this.department);
}

class CityCompanion extends UpdateCompanion<CityData> {
  final Value<int> rowId;
  final Value<String> city;
  final Value<String> department;
  const CityCompanion({
    this.rowId = const Value.absent(),
    this.city = const Value.absent(),
    this.department = const Value.absent(),
  });
  CityCompanion.insert({
    this.rowId = const Value.absent(),
    required String city,
    required String department,
  })  : city = Value(city),
        department = Value(department);
  static Insertable<CityData> custom({
    Expression<int>? rowId,
    Expression<String>? city,
    Expression<String>? department,
  }) {
    return RawValuesInsertable({
      if (rowId != null) 'row_id': rowId,
      if (city != null) 'city': city,
      if (department != null) 'department': department,
    });
  }

  CityCompanion copyWith(
      {Value<int>? rowId, Value<String>? city, Value<String>? department}) {
    return CityCompanion(
      rowId: rowId ?? this.rowId,
      city: city ?? this.city,
      department: department ?? this.department,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (rowId.present) {
      map['row_id'] = Variable<int>(rowId.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (department.present) {
      map['department'] = Variable<String>(department.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CityCompanion(')
          ..write('rowId: $rowId, ')
          ..write('city: $city, ')
          ..write('department: $department')
          ..write(')'))
        .toString();
  }
}

class Customer extends Table with TableInfo<Customer, CustomerData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Customer(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  late final GeneratedColumn<int> cityRowId = GeneratedColumn<int>(
      'city_row_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES city (row_id)'));
  late final GeneratedColumn<String> businessName = GeneratedColumn<String>(
      'business_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [uuid, name, phone, address, cityRowId, businessName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customer';
  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  CustomerData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomerData(
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone'])!,
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address'])!,
      cityRowId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}city_row_id'])!,
      businessName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}business_name']),
    );
  }

  @override
  Customer createAlias(String alias) {
    return Customer(attachedDatabase, alias);
  }
}

class CustomerData extends DataClass implements Insertable<CustomerData> {
  final String uuid;
  final String name;
  final String phone;
  final String address;
  final int cityRowId;
  final String? businessName;
  const CustomerData(
      {required this.uuid,
      required this.name,
      required this.phone,
      required this.address,
      required this.cityRowId,
      this.businessName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    map['name'] = Variable<String>(name);
    map['phone'] = Variable<String>(phone);
    map['address'] = Variable<String>(address);
    map['city_row_id'] = Variable<int>(cityRowId);
    if (!nullToAbsent || businessName != null) {
      map['business_name'] = Variable<String>(businessName);
    }
    return map;
  }

  CustomerCompanion toCompanion(bool nullToAbsent) {
    return CustomerCompanion(
      uuid: Value(uuid),
      name: Value(name),
      phone: Value(phone),
      address: Value(address),
      cityRowId: Value(cityRowId),
      businessName: businessName == null && nullToAbsent
          ? const Value.absent()
          : Value(businessName),
    );
  }

  factory CustomerData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomerData(
      uuid: serializer.fromJson<String>(json['uuid']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String>(json['phone']),
      address: serializer.fromJson<String>(json['address']),
      cityRowId: serializer.fromJson<int>(json['cityRowId']),
      businessName: serializer.fromJson<String?>(json['businessName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String>(phone),
      'address': serializer.toJson<String>(address),
      'cityRowId': serializer.toJson<int>(cityRowId),
      'businessName': serializer.toJson<String?>(businessName),
    };
  }

  CustomerData copyWith(
          {String? uuid,
          String? name,
          String? phone,
          String? address,
          int? cityRowId,
          Value<String?> businessName = const Value.absent()}) =>
      CustomerData(
        uuid: uuid ?? this.uuid,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        cityRowId: cityRowId ?? this.cityRowId,
        businessName:
            businessName.present ? businessName.value : this.businessName,
      );
  CustomerData copyWithCompanion(CustomerCompanion data) {
    return CustomerData(
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
      cityRowId: data.cityRowId.present ? data.cityRowId.value : this.cityRowId,
      businessName: data.businessName.present
          ? data.businessName.value
          : this.businessName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomerData(')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('cityRowId: $cityRowId, ')
          ..write('businessName: $businessName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(uuid, name, phone, address, cityRowId, businessName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomerData &&
          other.uuid == this.uuid &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.cityRowId == this.cityRowId &&
          other.businessName == this.businessName);
}

class CustomerCompanion extends UpdateCompanion<CustomerData> {
  final Value<String> uuid;
  final Value<String> name;
  final Value<String> phone;
  final Value<String> address;
  final Value<int> cityRowId;
  final Value<String?> businessName;
  final Value<int> rowid;
  const CustomerCompanion({
    this.uuid = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.cityRowId = const Value.absent(),
    this.businessName = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CustomerCompanion.insert({
    required String uuid,
    required String name,
    required String phone,
    required String address,
    required int cityRowId,
    this.businessName = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : uuid = Value(uuid),
        name = Value(name),
        phone = Value(phone),
        address = Value(address),
        cityRowId = Value(cityRowId);
  static Insertable<CustomerData> custom({
    Expression<String>? uuid,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<int>? cityRowId,
    Expression<String>? businessName,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (cityRowId != null) 'city_row_id': cityRowId,
      if (businessName != null) 'business_name': businessName,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CustomerCompanion copyWith(
      {Value<String>? uuid,
      Value<String>? name,
      Value<String>? phone,
      Value<String>? address,
      Value<int>? cityRowId,
      Value<String?>? businessName,
      Value<int>? rowid}) {
    return CustomerCompanion(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      cityRowId: cityRowId ?? this.cityRowId,
      businessName: businessName ?? this.businessName,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (cityRowId.present) {
      map['city_row_id'] = Variable<int>(cityRowId.value);
    }
    if (businessName.present) {
      map['business_name'] = Variable<String>(businessName.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomerCompanion(')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('cityRowId: $cityRowId, ')
          ..write('businessName: $businessName, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class CustomerMemento extends Table
    with TableInfo<CustomerMemento, CustomerMementoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  CustomerMemento(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: const CustomExpression(
          'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)'));
  late final GeneratedColumn<String> data = GeneratedColumn<String>(
      'data', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
      'version', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  late final GeneratedColumn<String> customerUuid = GeneratedColumn<String>(
      'customer_uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES customer (uuid)'));
  @override
  List<GeneratedColumn> get $columns =>
      [uuid, date, data, version, customerUuid];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customer_memento';
  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  CustomerMementoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomerMementoData(
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      data: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}data'])!,
      version: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}version'])!,
      customerUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}customer_uuid'])!,
    );
  }

  @override
  CustomerMemento createAlias(String alias) {
    return CustomerMemento(attachedDatabase, alias);
  }
}

class CustomerMementoData extends DataClass
    implements Insertable<CustomerMementoData> {
  final String uuid;
  final DateTime date;
  final String data;
  final int version;
  final String customerUuid;
  const CustomerMementoData(
      {required this.uuid,
      required this.date,
      required this.data,
      required this.version,
      required this.customerUuid});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    map['date'] = Variable<DateTime>(date);
    map['data'] = Variable<String>(data);
    map['version'] = Variable<int>(version);
    map['customer_uuid'] = Variable<String>(customerUuid);
    return map;
  }

  CustomerMementoCompanion toCompanion(bool nullToAbsent) {
    return CustomerMementoCompanion(
      uuid: Value(uuid),
      date: Value(date),
      data: Value(data),
      version: Value(version),
      customerUuid: Value(customerUuid),
    );
  }

  factory CustomerMementoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomerMementoData(
      uuid: serializer.fromJson<String>(json['uuid']),
      date: serializer.fromJson<DateTime>(json['date']),
      data: serializer.fromJson<String>(json['data']),
      version: serializer.fromJson<int>(json['version']),
      customerUuid: serializer.fromJson<String>(json['customerUuid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'date': serializer.toJson<DateTime>(date),
      'data': serializer.toJson<String>(data),
      'version': serializer.toJson<int>(version),
      'customerUuid': serializer.toJson<String>(customerUuid),
    };
  }

  CustomerMementoData copyWith(
          {String? uuid,
          DateTime? date,
          String? data,
          int? version,
          String? customerUuid}) =>
      CustomerMementoData(
        uuid: uuid ?? this.uuid,
        date: date ?? this.date,
        data: data ?? this.data,
        version: version ?? this.version,
        customerUuid: customerUuid ?? this.customerUuid,
      );
  CustomerMementoData copyWithCompanion(CustomerMementoCompanion data) {
    return CustomerMementoData(
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      date: data.date.present ? data.date.value : this.date,
      data: data.data.present ? data.data.value : this.data,
      version: data.version.present ? data.version.value : this.version,
      customerUuid: data.customerUuid.present
          ? data.customerUuid.value
          : this.customerUuid,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomerMementoData(')
          ..write('uuid: $uuid, ')
          ..write('date: $date, ')
          ..write('data: $data, ')
          ..write('version: $version, ')
          ..write('customerUuid: $customerUuid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(uuid, date, data, version, customerUuid);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomerMementoData &&
          other.uuid == this.uuid &&
          other.date == this.date &&
          other.data == this.data &&
          other.version == this.version &&
          other.customerUuid == this.customerUuid);
}

class CustomerMementoCompanion extends UpdateCompanion<CustomerMementoData> {
  final Value<String> uuid;
  final Value<DateTime> date;
  final Value<String> data;
  final Value<int> version;
  final Value<String> customerUuid;
  final Value<int> rowid;
  const CustomerMementoCompanion({
    this.uuid = const Value.absent(),
    this.date = const Value.absent(),
    this.data = const Value.absent(),
    this.version = const Value.absent(),
    this.customerUuid = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CustomerMementoCompanion.insert({
    required String uuid,
    this.date = const Value.absent(),
    required String data,
    required int version,
    required String customerUuid,
    this.rowid = const Value.absent(),
  })  : uuid = Value(uuid),
        data = Value(data),
        version = Value(version),
        customerUuid = Value(customerUuid);
  static Insertable<CustomerMementoData> custom({
    Expression<String>? uuid,
    Expression<DateTime>? date,
    Expression<String>? data,
    Expression<int>? version,
    Expression<String>? customerUuid,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (date != null) 'date': date,
      if (data != null) 'data': data,
      if (version != null) 'version': version,
      if (customerUuid != null) 'customer_uuid': customerUuid,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CustomerMementoCompanion copyWith(
      {Value<String>? uuid,
      Value<DateTime>? date,
      Value<String>? data,
      Value<int>? version,
      Value<String>? customerUuid,
      Value<int>? rowid}) {
    return CustomerMementoCompanion(
      uuid: uuid ?? this.uuid,
      date: date ?? this.date,
      data: data ?? this.data,
      version: version ?? this.version,
      customerUuid: customerUuid ?? this.customerUuid,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (data.present) {
      map['data'] = Variable<String>(data.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (customerUuid.present) {
      map['customer_uuid'] = Variable<String>(customerUuid.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomerMementoCompanion(')
          ..write('uuid: $uuid, ')
          ..write('date: $date, ')
          ..write('data: $data, ')
          ..write('version: $version, ')
          ..write('customerUuid: $customerUuid, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Invoice extends Table with TableInfo<Invoice, InvoiceData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Invoice(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  late final GeneratedColumn<int> number = GeneratedColumn<int>(
      'number', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: const CustomExpression(
          'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)'));
  late final GeneratedColumn<int> discount = GeneratedColumn<int>(
      'discount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  late final GeneratedColumn<String> customerUuid = GeneratedColumn<String>(
      'customer_uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES customer (uuid)'));
  @override
  List<GeneratedColumn> get $columns =>
      [uuid, number, date, discount, customerUuid];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoice';
  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  InvoiceData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvoiceData(
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      number: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}number'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      discount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}discount'])!,
      customerUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}customer_uuid'])!,
    );
  }

  @override
  Invoice createAlias(String alias) {
    return Invoice(attachedDatabase, alias);
  }
}

class InvoiceData extends DataClass implements Insertable<InvoiceData> {
  final String uuid;
  final int number;
  final DateTime date;
  final int discount;
  final String customerUuid;
  const InvoiceData(
      {required this.uuid,
      required this.number,
      required this.date,
      required this.discount,
      required this.customerUuid});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    map['number'] = Variable<int>(number);
    map['date'] = Variable<DateTime>(date);
    map['discount'] = Variable<int>(discount);
    map['customer_uuid'] = Variable<String>(customerUuid);
    return map;
  }

  InvoiceCompanion toCompanion(bool nullToAbsent) {
    return InvoiceCompanion(
      uuid: Value(uuid),
      number: Value(number),
      date: Value(date),
      discount: Value(discount),
      customerUuid: Value(customerUuid),
    );
  }

  factory InvoiceData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvoiceData(
      uuid: serializer.fromJson<String>(json['uuid']),
      number: serializer.fromJson<int>(json['number']),
      date: serializer.fromJson<DateTime>(json['date']),
      discount: serializer.fromJson<int>(json['discount']),
      customerUuid: serializer.fromJson<String>(json['customerUuid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'number': serializer.toJson<int>(number),
      'date': serializer.toJson<DateTime>(date),
      'discount': serializer.toJson<int>(discount),
      'customerUuid': serializer.toJson<String>(customerUuid),
    };
  }

  InvoiceData copyWith(
          {String? uuid,
          int? number,
          DateTime? date,
          int? discount,
          String? customerUuid}) =>
      InvoiceData(
        uuid: uuid ?? this.uuid,
        number: number ?? this.number,
        date: date ?? this.date,
        discount: discount ?? this.discount,
        customerUuid: customerUuid ?? this.customerUuid,
      );
  InvoiceData copyWithCompanion(InvoiceCompanion data) {
    return InvoiceData(
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      number: data.number.present ? data.number.value : this.number,
      date: data.date.present ? data.date.value : this.date,
      discount: data.discount.present ? data.discount.value : this.discount,
      customerUuid: data.customerUuid.present
          ? data.customerUuid.value
          : this.customerUuid,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceData(')
          ..write('uuid: $uuid, ')
          ..write('number: $number, ')
          ..write('date: $date, ')
          ..write('discount: $discount, ')
          ..write('customerUuid: $customerUuid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(uuid, number, date, discount, customerUuid);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvoiceData &&
          other.uuid == this.uuid &&
          other.number == this.number &&
          other.date == this.date &&
          other.discount == this.discount &&
          other.customerUuid == this.customerUuid);
}

class InvoiceCompanion extends UpdateCompanion<InvoiceData> {
  final Value<String> uuid;
  final Value<int> number;
  final Value<DateTime> date;
  final Value<int> discount;
  final Value<String> customerUuid;
  final Value<int> rowid;
  const InvoiceCompanion({
    this.uuid = const Value.absent(),
    this.number = const Value.absent(),
    this.date = const Value.absent(),
    this.discount = const Value.absent(),
    this.customerUuid = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InvoiceCompanion.insert({
    required String uuid,
    required int number,
    this.date = const Value.absent(),
    required int discount,
    required String customerUuid,
    this.rowid = const Value.absent(),
  })  : uuid = Value(uuid),
        number = Value(number),
        discount = Value(discount),
        customerUuid = Value(customerUuid);
  static Insertable<InvoiceData> custom({
    Expression<String>? uuid,
    Expression<int>? number,
    Expression<DateTime>? date,
    Expression<int>? discount,
    Expression<String>? customerUuid,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (number != null) 'number': number,
      if (date != null) 'date': date,
      if (discount != null) 'discount': discount,
      if (customerUuid != null) 'customer_uuid': customerUuid,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InvoiceCompanion copyWith(
      {Value<String>? uuid,
      Value<int>? number,
      Value<DateTime>? date,
      Value<int>? discount,
      Value<String>? customerUuid,
      Value<int>? rowid}) {
    return InvoiceCompanion(
      uuid: uuid ?? this.uuid,
      number: number ?? this.number,
      date: date ?? this.date,
      discount: discount ?? this.discount,
      customerUuid: customerUuid ?? this.customerUuid,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (number.present) {
      map['number'] = Variable<int>(number.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (discount.present) {
      map['discount'] = Variable<int>(discount.value);
    }
    if (customerUuid.present) {
      map['customer_uuid'] = Variable<String>(customerUuid.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceCompanion(')
          ..write('uuid: $uuid, ')
          ..write('number: $number, ')
          ..write('date: $date, ')
          ..write('discount: $discount, ')
          ..write('customerUuid: $customerUuid, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Product extends Table with TableInfo<Product, ProductData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Product(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  late final GeneratedColumn<BigInt> price = GeneratedColumn<BigInt>(
      'price', aliasedName, false,
      type: DriftSqlType.bigInt, requiredDuringInsert: true);
  late final GeneratedColumn<int> stock = GeneratedColumn<int>(
      'stock', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [uuid, name, price, stock];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product';
  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  ProductData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductData(
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.bigInt, data['${effectivePrefix}price'])!,
      stock: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stock'])!,
    );
  }

  @override
  Product createAlias(String alias) {
    return Product(attachedDatabase, alias);
  }
}

class ProductData extends DataClass implements Insertable<ProductData> {
  final String uuid;
  final String name;
  final BigInt price;
  final int stock;
  const ProductData(
      {required this.uuid,
      required this.name,
      required this.price,
      required this.stock});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    map['name'] = Variable<String>(name);
    map['price'] = Variable<BigInt>(price);
    map['stock'] = Variable<int>(stock);
    return map;
  }

  ProductCompanion toCompanion(bool nullToAbsent) {
    return ProductCompanion(
      uuid: Value(uuid),
      name: Value(name),
      price: Value(price),
      stock: Value(stock),
    );
  }

  factory ProductData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductData(
      uuid: serializer.fromJson<String>(json['uuid']),
      name: serializer.fromJson<String>(json['name']),
      price: serializer.fromJson<BigInt>(json['price']),
      stock: serializer.fromJson<int>(json['stock']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'name': serializer.toJson<String>(name),
      'price': serializer.toJson<BigInt>(price),
      'stock': serializer.toJson<int>(stock),
    };
  }

  ProductData copyWith(
          {String? uuid, String? name, BigInt? price, int? stock}) =>
      ProductData(
        uuid: uuid ?? this.uuid,
        name: name ?? this.name,
        price: price ?? this.price,
        stock: stock ?? this.stock,
      );
  ProductData copyWithCompanion(ProductCompanion data) {
    return ProductData(
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      name: data.name.present ? data.name.value : this.name,
      price: data.price.present ? data.price.value : this.price,
      stock: data.stock.present ? data.stock.value : this.stock,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductData(')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('stock: $stock')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(uuid, name, price, stock);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductData &&
          other.uuid == this.uuid &&
          other.name == this.name &&
          other.price == this.price &&
          other.stock == this.stock);
}

class ProductCompanion extends UpdateCompanion<ProductData> {
  final Value<String> uuid;
  final Value<String> name;
  final Value<BigInt> price;
  final Value<int> stock;
  final Value<int> rowid;
  const ProductCompanion({
    this.uuid = const Value.absent(),
    this.name = const Value.absent(),
    this.price = const Value.absent(),
    this.stock = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductCompanion.insert({
    required String uuid,
    required String name,
    required BigInt price,
    required int stock,
    this.rowid = const Value.absent(),
  })  : uuid = Value(uuid),
        name = Value(name),
        price = Value(price),
        stock = Value(stock);
  static Insertable<ProductData> custom({
    Expression<String>? uuid,
    Expression<String>? name,
    Expression<BigInt>? price,
    Expression<int>? stock,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (name != null) 'name': name,
      if (price != null) 'price': price,
      if (stock != null) 'stock': stock,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductCompanion copyWith(
      {Value<String>? uuid,
      Value<String>? name,
      Value<BigInt>? price,
      Value<int>? stock,
      Value<int>? rowid}) {
    return ProductCompanion(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (price.present) {
      map['price'] = Variable<BigInt>(price.value);
    }
    if (stock.present) {
      map['stock'] = Variable<int>(stock.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductCompanion(')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('stock: $stock, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class ProductInvoice extends Table
    with TableInfo<ProductInvoice, ProductInvoiceData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ProductInvoice(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> count = GeneratedColumn<int>(
      'count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  late final GeneratedColumn<BigInt> price = GeneratedColumn<BigInt>(
      'price', aliasedName, false,
      type: DriftSqlType.bigInt, requiredDuringInsert: true);
  late final GeneratedColumn<BigInt> discount = GeneratedColumn<BigInt>(
      'discount', aliasedName, false,
      type: DriftSqlType.bigInt, requiredDuringInsert: true);
  late final GeneratedColumn<String> productUuid = GeneratedColumn<String>(
      'product_uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES product (uuid)'));
  late final GeneratedColumn<String> invoiceUuid = GeneratedColumn<String>(
      'invoice_uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES invoice (uuid)'));
  @override
  List<GeneratedColumn> get $columns =>
      [count, price, discount, productUuid, invoiceUuid];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_invoice';
  @override
  Set<GeneratedColumn> get $primaryKey => {productUuid, invoiceUuid};
  @override
  ProductInvoiceData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductInvoiceData(
      count: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}count'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.bigInt, data['${effectivePrefix}price'])!,
      discount: attachedDatabase.typeMapping
          .read(DriftSqlType.bigInt, data['${effectivePrefix}discount'])!,
      productUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_uuid'])!,
      invoiceUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}invoice_uuid'])!,
    );
  }

  @override
  ProductInvoice createAlias(String alias) {
    return ProductInvoice(attachedDatabase, alias);
  }
}

class ProductInvoiceData extends DataClass
    implements Insertable<ProductInvoiceData> {
  final int count;
  final BigInt price;
  final BigInt discount;
  final String productUuid;
  final String invoiceUuid;
  const ProductInvoiceData(
      {required this.count,
      required this.price,
      required this.discount,
      required this.productUuid,
      required this.invoiceUuid});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['count'] = Variable<int>(count);
    map['price'] = Variable<BigInt>(price);
    map['discount'] = Variable<BigInt>(discount);
    map['product_uuid'] = Variable<String>(productUuid);
    map['invoice_uuid'] = Variable<String>(invoiceUuid);
    return map;
  }

  ProductInvoiceCompanion toCompanion(bool nullToAbsent) {
    return ProductInvoiceCompanion(
      count: Value(count),
      price: Value(price),
      discount: Value(discount),
      productUuid: Value(productUuid),
      invoiceUuid: Value(invoiceUuid),
    );
  }

  factory ProductInvoiceData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductInvoiceData(
      count: serializer.fromJson<int>(json['count']),
      price: serializer.fromJson<BigInt>(json['price']),
      discount: serializer.fromJson<BigInt>(json['discount']),
      productUuid: serializer.fromJson<String>(json['productUuid']),
      invoiceUuid: serializer.fromJson<String>(json['invoiceUuid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'count': serializer.toJson<int>(count),
      'price': serializer.toJson<BigInt>(price),
      'discount': serializer.toJson<BigInt>(discount),
      'productUuid': serializer.toJson<String>(productUuid),
      'invoiceUuid': serializer.toJson<String>(invoiceUuid),
    };
  }

  ProductInvoiceData copyWith(
          {int? count,
          BigInt? price,
          BigInt? discount,
          String? productUuid,
          String? invoiceUuid}) =>
      ProductInvoiceData(
        count: count ?? this.count,
        price: price ?? this.price,
        discount: discount ?? this.discount,
        productUuid: productUuid ?? this.productUuid,
        invoiceUuid: invoiceUuid ?? this.invoiceUuid,
      );
  ProductInvoiceData copyWithCompanion(ProductInvoiceCompanion data) {
    return ProductInvoiceData(
      count: data.count.present ? data.count.value : this.count,
      price: data.price.present ? data.price.value : this.price,
      discount: data.discount.present ? data.discount.value : this.discount,
      productUuid:
          data.productUuid.present ? data.productUuid.value : this.productUuid,
      invoiceUuid:
          data.invoiceUuid.present ? data.invoiceUuid.value : this.invoiceUuid,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductInvoiceData(')
          ..write('count: $count, ')
          ..write('price: $price, ')
          ..write('discount: $discount, ')
          ..write('productUuid: $productUuid, ')
          ..write('invoiceUuid: $invoiceUuid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(count, price, discount, productUuid, invoiceUuid);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductInvoiceData &&
          other.count == this.count &&
          other.price == this.price &&
          other.discount == this.discount &&
          other.productUuid == this.productUuid &&
          other.invoiceUuid == this.invoiceUuid);
}

class ProductInvoiceCompanion extends UpdateCompanion<ProductInvoiceData> {
  final Value<int> count;
  final Value<BigInt> price;
  final Value<BigInt> discount;
  final Value<String> productUuid;
  final Value<String> invoiceUuid;
  final Value<int> rowid;
  const ProductInvoiceCompanion({
    this.count = const Value.absent(),
    this.price = const Value.absent(),
    this.discount = const Value.absent(),
    this.productUuid = const Value.absent(),
    this.invoiceUuid = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductInvoiceCompanion.insert({
    required int count,
    required BigInt price,
    required BigInt discount,
    required String productUuid,
    required String invoiceUuid,
    this.rowid = const Value.absent(),
  })  : count = Value(count),
        price = Value(price),
        discount = Value(discount),
        productUuid = Value(productUuid),
        invoiceUuid = Value(invoiceUuid);
  static Insertable<ProductInvoiceData> custom({
    Expression<int>? count,
    Expression<BigInt>? price,
    Expression<BigInt>? discount,
    Expression<String>? productUuid,
    Expression<String>? invoiceUuid,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (count != null) 'count': count,
      if (price != null) 'price': price,
      if (discount != null) 'discount': discount,
      if (productUuid != null) 'product_uuid': productUuid,
      if (invoiceUuid != null) 'invoice_uuid': invoiceUuid,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductInvoiceCompanion copyWith(
      {Value<int>? count,
      Value<BigInt>? price,
      Value<BigInt>? discount,
      Value<String>? productUuid,
      Value<String>? invoiceUuid,
      Value<int>? rowid}) {
    return ProductInvoiceCompanion(
      count: count ?? this.count,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      productUuid: productUuid ?? this.productUuid,
      invoiceUuid: invoiceUuid ?? this.invoiceUuid,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (price.present) {
      map['price'] = Variable<BigInt>(price.value);
    }
    if (discount.present) {
      map['discount'] = Variable<BigInt>(discount.value);
    }
    if (productUuid.present) {
      map['product_uuid'] = Variable<String>(productUuid.value);
    }
    if (invoiceUuid.present) {
      map['invoice_uuid'] = Variable<String>(invoiceUuid.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductInvoiceCompanion(')
          ..write('count: $count, ')
          ..write('price: $price, ')
          ..write('discount: $discount, ')
          ..write('productUuid: $productUuid, ')
          ..write('invoiceUuid: $invoiceUuid, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class ProductMemento extends Table
    with TableInfo<ProductMemento, ProductMementoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ProductMemento(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: const CustomExpression(
          'CAST(strftime(\'%s\', CURRENT_TIMESTAMP) AS INTEGER)'));
  late final GeneratedColumn<String> data = GeneratedColumn<String>(
      'data', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
      'version', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  late final GeneratedColumn<String> productUuid = GeneratedColumn<String>(
      'product_uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES product (uuid)'));
  @override
  List<GeneratedColumn> get $columns =>
      [uuid, date, data, version, productUuid];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_memento';
  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  ProductMementoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductMementoData(
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      data: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}data'])!,
      version: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}version'])!,
      productUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_uuid'])!,
    );
  }

  @override
  ProductMemento createAlias(String alias) {
    return ProductMemento(attachedDatabase, alias);
  }
}

class ProductMementoData extends DataClass
    implements Insertable<ProductMementoData> {
  final String uuid;
  final DateTime date;
  final String data;
  final int version;
  final String productUuid;
  const ProductMementoData(
      {required this.uuid,
      required this.date,
      required this.data,
      required this.version,
      required this.productUuid});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    map['date'] = Variable<DateTime>(date);
    map['data'] = Variable<String>(data);
    map['version'] = Variable<int>(version);
    map['product_uuid'] = Variable<String>(productUuid);
    return map;
  }

  ProductMementoCompanion toCompanion(bool nullToAbsent) {
    return ProductMementoCompanion(
      uuid: Value(uuid),
      date: Value(date),
      data: Value(data),
      version: Value(version),
      productUuid: Value(productUuid),
    );
  }

  factory ProductMementoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductMementoData(
      uuid: serializer.fromJson<String>(json['uuid']),
      date: serializer.fromJson<DateTime>(json['date']),
      data: serializer.fromJson<String>(json['data']),
      version: serializer.fromJson<int>(json['version']),
      productUuid: serializer.fromJson<String>(json['productUuid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'date': serializer.toJson<DateTime>(date),
      'data': serializer.toJson<String>(data),
      'version': serializer.toJson<int>(version),
      'productUuid': serializer.toJson<String>(productUuid),
    };
  }

  ProductMementoData copyWith(
          {String? uuid,
          DateTime? date,
          String? data,
          int? version,
          String? productUuid}) =>
      ProductMementoData(
        uuid: uuid ?? this.uuid,
        date: date ?? this.date,
        data: data ?? this.data,
        version: version ?? this.version,
        productUuid: productUuid ?? this.productUuid,
      );
  ProductMementoData copyWithCompanion(ProductMementoCompanion data) {
    return ProductMementoData(
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      date: data.date.present ? data.date.value : this.date,
      data: data.data.present ? data.data.value : this.data,
      version: data.version.present ? data.version.value : this.version,
      productUuid:
          data.productUuid.present ? data.productUuid.value : this.productUuid,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductMementoData(')
          ..write('uuid: $uuid, ')
          ..write('date: $date, ')
          ..write('data: $data, ')
          ..write('version: $version, ')
          ..write('productUuid: $productUuid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(uuid, date, data, version, productUuid);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductMementoData &&
          other.uuid == this.uuid &&
          other.date == this.date &&
          other.data == this.data &&
          other.version == this.version &&
          other.productUuid == this.productUuid);
}

class ProductMementoCompanion extends UpdateCompanion<ProductMementoData> {
  final Value<String> uuid;
  final Value<DateTime> date;
  final Value<String> data;
  final Value<int> version;
  final Value<String> productUuid;
  final Value<int> rowid;
  const ProductMementoCompanion({
    this.uuid = const Value.absent(),
    this.date = const Value.absent(),
    this.data = const Value.absent(),
    this.version = const Value.absent(),
    this.productUuid = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductMementoCompanion.insert({
    required String uuid,
    this.date = const Value.absent(),
    required String data,
    required int version,
    required String productUuid,
    this.rowid = const Value.absent(),
  })  : uuid = Value(uuid),
        data = Value(data),
        version = Value(version),
        productUuid = Value(productUuid);
  static Insertable<ProductMementoData> custom({
    Expression<String>? uuid,
    Expression<DateTime>? date,
    Expression<String>? data,
    Expression<int>? version,
    Expression<String>? productUuid,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (date != null) 'date': date,
      if (data != null) 'data': data,
      if (version != null) 'version': version,
      if (productUuid != null) 'product_uuid': productUuid,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductMementoCompanion copyWith(
      {Value<String>? uuid,
      Value<DateTime>? date,
      Value<String>? data,
      Value<int>? version,
      Value<String>? productUuid,
      Value<int>? rowid}) {
    return ProductMementoCompanion(
      uuid: uuid ?? this.uuid,
      date: date ?? this.date,
      data: data ?? this.data,
      version: version ?? this.version,
      productUuid: productUuid ?? this.productUuid,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (data.present) {
      map['data'] = Variable<String>(data.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (productUuid.present) {
      map['product_uuid'] = Variable<String>(productUuid.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductMementoCompanion(')
          ..write('uuid: $uuid, ')
          ..write('date: $date, ')
          ..write('data: $data, ')
          ..write('version: $version, ')
          ..write('productUuid: $productUuid, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class DatabaseAtV2 extends GeneratedDatabase {
  DatabaseAtV2(QueryExecutor e) : super(e);
  late final City city = City(this);
  late final Customer customer = Customer(this);
  late final CustomerMemento customerMemento = CustomerMemento(this);
  late final Invoice invoice = Invoice(this);
  late final Product product = Product(this);
  late final ProductInvoice productInvoice = ProductInvoice(this);
  late final ProductMemento productMemento = ProductMemento(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        city,
        customer,
        customerMemento,
        invoice,
        product,
        productInvoice,
        productMemento
      ];
  @override
  int get schemaVersion => 2;
}
