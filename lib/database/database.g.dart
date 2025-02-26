// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CityTable extends City with TableInfo<$CityTable, CityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CityTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumn<int> rowId = GeneratedColumn<int>(
      'row_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
      'city', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
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
  $CityTable createAlias(String alias) {
    return $CityTable(attachedDatabase, alias);
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

class $CustomerTable extends Customer
    with TableInfo<$CustomerTable, CustomerData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomerTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => Uuid().v1());
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumn<int> cityRowId = GeneratedColumn<int>(
      'city_row_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES city (row_id)'));
  @override
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
  $CustomerTable createAlias(String alias) {
    return $CustomerTable(attachedDatabase, alias);
  }
}

class CustomerData extends DataClass implements Insertable<CustomerData> {
  final String uuid;
  final String name;
  final String phone;
  final String address;
  final int cityRowId;

  /// Nullable
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
    this.uuid = const Value.absent(),
    required String name,
    required String phone,
    required String address,
    required int cityRowId,
    this.businessName = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : name = Value(name),
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

class $CustomerMementoTable extends CustomerMemento
    with TableInfo<$CustomerMementoTable, CustomerMementoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomerMementoTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => Uuid().v1());
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDate);
  @override
  late final GeneratedColumn<String> data = GeneratedColumn<String>(
      'data', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
      'version', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  late final GeneratedColumn<String> clientUuid = GeneratedColumn<String>(
      'client_uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES customer (uuid)'));
  @override
  List<GeneratedColumn> get $columns => [uuid, date, data, version, clientUuid];
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
      clientUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}client_uuid'])!,
    );
  }

  @override
  $CustomerMementoTable createAlias(String alias) {
    return $CustomerMementoTable(attachedDatabase, alias);
  }
}

class CustomerMementoData extends DataClass
    implements Insertable<CustomerMementoData> {
  final String uuid;
  final DateTime date;
  final String data;
  final int version;
  final String clientUuid;
  const CustomerMementoData(
      {required this.uuid,
      required this.date,
      required this.data,
      required this.version,
      required this.clientUuid});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    map['date'] = Variable<DateTime>(date);
    map['data'] = Variable<String>(data);
    map['version'] = Variable<int>(version);
    map['client_uuid'] = Variable<String>(clientUuid);
    return map;
  }

  CustomerMementoCompanion toCompanion(bool nullToAbsent) {
    return CustomerMementoCompanion(
      uuid: Value(uuid),
      date: Value(date),
      data: Value(data),
      version: Value(version),
      clientUuid: Value(clientUuid),
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
      clientUuid: serializer.fromJson<String>(json['clientUuid']),
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
      'clientUuid': serializer.toJson<String>(clientUuid),
    };
  }

  CustomerMementoData copyWith(
          {String? uuid,
          DateTime? date,
          String? data,
          int? version,
          String? clientUuid}) =>
      CustomerMementoData(
        uuid: uuid ?? this.uuid,
        date: date ?? this.date,
        data: data ?? this.data,
        version: version ?? this.version,
        clientUuid: clientUuid ?? this.clientUuid,
      );
  CustomerMementoData copyWithCompanion(CustomerMementoCompanion data) {
    return CustomerMementoData(
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      date: data.date.present ? data.date.value : this.date,
      data: data.data.present ? data.data.value : this.data,
      version: data.version.present ? data.version.value : this.version,
      clientUuid:
          data.clientUuid.present ? data.clientUuid.value : this.clientUuid,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomerMementoData(')
          ..write('uuid: $uuid, ')
          ..write('date: $date, ')
          ..write('data: $data, ')
          ..write('version: $version, ')
          ..write('clientUuid: $clientUuid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(uuid, date, data, version, clientUuid);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomerMementoData &&
          other.uuid == this.uuid &&
          other.date == this.date &&
          other.data == this.data &&
          other.version == this.version &&
          other.clientUuid == this.clientUuid);
}

class CustomerMementoCompanion extends UpdateCompanion<CustomerMementoData> {
  final Value<String> uuid;
  final Value<DateTime> date;
  final Value<String> data;
  final Value<int> version;
  final Value<String> clientUuid;
  final Value<int> rowid;
  const CustomerMementoCompanion({
    this.uuid = const Value.absent(),
    this.date = const Value.absent(),
    this.data = const Value.absent(),
    this.version = const Value.absent(),
    this.clientUuid = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CustomerMementoCompanion.insert({
    this.uuid = const Value.absent(),
    this.date = const Value.absent(),
    required String data,
    required int version,
    required String clientUuid,
    this.rowid = const Value.absent(),
  })  : data = Value(data),
        version = Value(version),
        clientUuid = Value(clientUuid);
  static Insertable<CustomerMementoData> custom({
    Expression<String>? uuid,
    Expression<DateTime>? date,
    Expression<String>? data,
    Expression<int>? version,
    Expression<String>? clientUuid,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (date != null) 'date': date,
      if (data != null) 'data': data,
      if (version != null) 'version': version,
      if (clientUuid != null) 'client_uuid': clientUuid,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CustomerMementoCompanion copyWith(
      {Value<String>? uuid,
      Value<DateTime>? date,
      Value<String>? data,
      Value<int>? version,
      Value<String>? clientUuid,
      Value<int>? rowid}) {
    return CustomerMementoCompanion(
      uuid: uuid ?? this.uuid,
      date: date ?? this.date,
      data: data ?? this.data,
      version: version ?? this.version,
      clientUuid: clientUuid ?? this.clientUuid,
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
    if (clientUuid.present) {
      map['client_uuid'] = Variable<String>(clientUuid.value);
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
          ..write('clientUuid: $clientUuid, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InvoiceTable extends Invoice with TableInfo<$InvoiceTable, InvoiceData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoiceTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => Uuid().v1());
  @override
  late final GeneratedColumn<int> number = GeneratedColumn<int>(
      'number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDate);
  @override
  late final GeneratedColumn<int> discount = GeneratedColumn<int>(
      'discount', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      clientDefault: () => 0);
  @override
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
  $InvoiceTable createAlias(String alias) {
    return $InvoiceTable(attachedDatabase, alias);
  }
}

class InvoiceData extends DataClass implements Insertable<InvoiceData> {
  final String uuid;
  final int number;
  final DateTime date;
  final int discount;

  /// References.
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
    this.uuid = const Value.absent(),
    required int number,
    this.date = const Value.absent(),
    this.discount = const Value.absent(),
    required String customerUuid,
    this.rowid = const Value.absent(),
  })  : number = Value(number),
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

class $ProductTable extends Product with TableInfo<$ProductTable, ProductData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => Uuid().v1());
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumn<BigInt> price = GeneratedColumn<BigInt>(
      'price', aliasedName, false,
      type: DriftSqlType.bigInt, requiredDuringInsert: true);
  @override
  late final GeneratedColumn<int> stock = GeneratedColumn<int>(
      'stock', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [uuid, name, price, stock, code];
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
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code']),
    );
  }

  @override
  $ProductTable createAlias(String alias) {
    return $ProductTable(attachedDatabase, alias);
  }
}

class ProductData extends DataClass implements Insertable<ProductData> {
  final String uuid;
  final String name;
  final BigInt price;
  final int stock;
  final String? code;
  const ProductData(
      {required this.uuid,
      required this.name,
      required this.price,
      required this.stock,
      this.code});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    map['name'] = Variable<String>(name);
    map['price'] = Variable<BigInt>(price);
    map['stock'] = Variable<int>(stock);
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    return map;
  }

  ProductCompanion toCompanion(bool nullToAbsent) {
    return ProductCompanion(
      uuid: Value(uuid),
      name: Value(name),
      price: Value(price),
      stock: Value(stock),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
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
      code: serializer.fromJson<String?>(json['code']),
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
      'code': serializer.toJson<String?>(code),
    };
  }

  ProductData copyWith(
          {String? uuid,
          String? name,
          BigInt? price,
          int? stock,
          Value<String?> code = const Value.absent()}) =>
      ProductData(
        uuid: uuid ?? this.uuid,
        name: name ?? this.name,
        price: price ?? this.price,
        stock: stock ?? this.stock,
        code: code.present ? code.value : this.code,
      );
  ProductData copyWithCompanion(ProductCompanion data) {
    return ProductData(
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      name: data.name.present ? data.name.value : this.name,
      price: data.price.present ? data.price.value : this.price,
      stock: data.stock.present ? data.stock.value : this.stock,
      code: data.code.present ? data.code.value : this.code,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductData(')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('stock: $stock, ')
          ..write('code: $code')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(uuid, name, price, stock, code);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductData &&
          other.uuid == this.uuid &&
          other.name == this.name &&
          other.price == this.price &&
          other.stock == this.stock &&
          other.code == this.code);
}

class ProductCompanion extends UpdateCompanion<ProductData> {
  final Value<String> uuid;
  final Value<String> name;
  final Value<BigInt> price;
  final Value<int> stock;
  final Value<String?> code;
  final Value<int> rowid;
  const ProductCompanion({
    this.uuid = const Value.absent(),
    this.name = const Value.absent(),
    this.price = const Value.absent(),
    this.stock = const Value.absent(),
    this.code = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductCompanion.insert({
    this.uuid = const Value.absent(),
    required String name,
    required BigInt price,
    required int stock,
    this.code = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : name = Value(name),
        price = Value(price),
        stock = Value(stock);
  static Insertable<ProductData> custom({
    Expression<String>? uuid,
    Expression<String>? name,
    Expression<BigInt>? price,
    Expression<int>? stock,
    Expression<String>? code,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (name != null) 'name': name,
      if (price != null) 'price': price,
      if (stock != null) 'stock': stock,
      if (code != null) 'code': code,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductCompanion copyWith(
      {Value<String>? uuid,
      Value<String>? name,
      Value<BigInt>? price,
      Value<int>? stock,
      Value<String?>? code,
      Value<int>? rowid}) {
    return ProductCompanion(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      code: code ?? this.code,
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
    if (code.present) {
      map['code'] = Variable<String>(code.value);
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
          ..write('code: $code, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductInvoiceTable extends ProductInvoice
    with TableInfo<$ProductInvoiceTable, ProductInvoiceData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductInvoiceTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumn<int> price = GeneratedColumn<int>(
      'price', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  late final GeneratedColumn<int> count = GeneratedColumn<int>(
      'count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  late final GeneratedColumn<int> discount = GeneratedColumn<int>(
      'discount', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      clientDefault: () => 0);
  @override
  late final GeneratedColumn<String> productUuid = GeneratedColumn<String>(
      'product_uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES product (uuid)'));
  @override
  late final GeneratedColumn<String> invoiceUuid = GeneratedColumn<String>(
      'invoice_uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES invoice (uuid)'));
  @override
  List<GeneratedColumn> get $columns =>
      [price, count, discount, productUuid, invoiceUuid];
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
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}price'])!,
      count: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}count'])!,
      discount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}discount'])!,
      productUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_uuid'])!,
      invoiceUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}invoice_uuid'])!,
    );
  }

  @override
  $ProductInvoiceTable createAlias(String alias) {
    return $ProductInvoiceTable(attachedDatabase, alias);
  }
}

class ProductInvoiceData extends DataClass
    implements Insertable<ProductInvoiceData> {
  final int price;
  final int count;
  final int discount;

  /// References.
  final String productUuid;
  final String invoiceUuid;
  const ProductInvoiceData(
      {required this.price,
      required this.count,
      required this.discount,
      required this.productUuid,
      required this.invoiceUuid});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['price'] = Variable<int>(price);
    map['count'] = Variable<int>(count);
    map['discount'] = Variable<int>(discount);
    map['product_uuid'] = Variable<String>(productUuid);
    map['invoice_uuid'] = Variable<String>(invoiceUuid);
    return map;
  }

  ProductInvoiceCompanion toCompanion(bool nullToAbsent) {
    return ProductInvoiceCompanion(
      price: Value(price),
      count: Value(count),
      discount: Value(discount),
      productUuid: Value(productUuid),
      invoiceUuid: Value(invoiceUuid),
    );
  }

  factory ProductInvoiceData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductInvoiceData(
      price: serializer.fromJson<int>(json['price']),
      count: serializer.fromJson<int>(json['count']),
      discount: serializer.fromJson<int>(json['discount']),
      productUuid: serializer.fromJson<String>(json['productUuid']),
      invoiceUuid: serializer.fromJson<String>(json['invoiceUuid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'price': serializer.toJson<int>(price),
      'count': serializer.toJson<int>(count),
      'discount': serializer.toJson<int>(discount),
      'productUuid': serializer.toJson<String>(productUuid),
      'invoiceUuid': serializer.toJson<String>(invoiceUuid),
    };
  }

  ProductInvoiceData copyWith(
          {int? price,
          int? count,
          int? discount,
          String? productUuid,
          String? invoiceUuid}) =>
      ProductInvoiceData(
        price: price ?? this.price,
        count: count ?? this.count,
        discount: discount ?? this.discount,
        productUuid: productUuid ?? this.productUuid,
        invoiceUuid: invoiceUuid ?? this.invoiceUuid,
      );
  ProductInvoiceData copyWithCompanion(ProductInvoiceCompanion data) {
    return ProductInvoiceData(
      price: data.price.present ? data.price.value : this.price,
      count: data.count.present ? data.count.value : this.count,
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
          ..write('price: $price, ')
          ..write('count: $count, ')
          ..write('discount: $discount, ')
          ..write('productUuid: $productUuid, ')
          ..write('invoiceUuid: $invoiceUuid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(price, count, discount, productUuid, invoiceUuid);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductInvoiceData &&
          other.price == this.price &&
          other.count == this.count &&
          other.discount == this.discount &&
          other.productUuid == this.productUuid &&
          other.invoiceUuid == this.invoiceUuid);
}

class ProductInvoiceCompanion extends UpdateCompanion<ProductInvoiceData> {
  final Value<int> price;
  final Value<int> count;
  final Value<int> discount;
  final Value<String> productUuid;
  final Value<String> invoiceUuid;
  final Value<int> rowid;
  const ProductInvoiceCompanion({
    this.price = const Value.absent(),
    this.count = const Value.absent(),
    this.discount = const Value.absent(),
    this.productUuid = const Value.absent(),
    this.invoiceUuid = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductInvoiceCompanion.insert({
    required int price,
    required int count,
    this.discount = const Value.absent(),
    required String productUuid,
    required String invoiceUuid,
    this.rowid = const Value.absent(),
  })  : price = Value(price),
        count = Value(count),
        productUuid = Value(productUuid),
        invoiceUuid = Value(invoiceUuid);
  static Insertable<ProductInvoiceData> custom({
    Expression<int>? price,
    Expression<int>? count,
    Expression<int>? discount,
    Expression<String>? productUuid,
    Expression<String>? invoiceUuid,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (price != null) 'price': price,
      if (count != null) 'count': count,
      if (discount != null) 'discount': discount,
      if (productUuid != null) 'product_uuid': productUuid,
      if (invoiceUuid != null) 'invoice_uuid': invoiceUuid,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductInvoiceCompanion copyWith(
      {Value<int>? price,
      Value<int>? count,
      Value<int>? discount,
      Value<String>? productUuid,
      Value<String>? invoiceUuid,
      Value<int>? rowid}) {
    return ProductInvoiceCompanion(
      price: price ?? this.price,
      count: count ?? this.count,
      discount: discount ?? this.discount,
      productUuid: productUuid ?? this.productUuid,
      invoiceUuid: invoiceUuid ?? this.invoiceUuid,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (price.present) {
      map['price'] = Variable<int>(price.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (discount.present) {
      map['discount'] = Variable<int>(discount.value);
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
          ..write('price: $price, ')
          ..write('count: $count, ')
          ..write('discount: $discount, ')
          ..write('productUuid: $productUuid, ')
          ..write('invoiceUuid: $invoiceUuid, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductMementoTable extends ProductMemento
    with TableInfo<$ProductMementoTable, ProductMementoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductMementoTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => Uuid().v1());
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDate);
  @override
  late final GeneratedColumn<String> data = GeneratedColumn<String>(
      'data', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
      'version', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
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
  $ProductMementoTable createAlias(String alias) {
    return $ProductMementoTable(attachedDatabase, alias);
  }
}

class ProductMementoData extends DataClass
    implements Insertable<ProductMementoData> {
  final String uuid;
  final DateTime date;
  final String data;
  final int version;

  /// References
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
    this.uuid = const Value.absent(),
    this.date = const Value.absent(),
    required String data,
    required int version,
    required String productUuid,
    this.rowid = const Value.absent(),
  })  : data = Value(data),
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

abstract class _$ShelfDatabase extends GeneratedDatabase {
  _$ShelfDatabase(QueryExecutor e) : super(e);
  $ShelfDatabaseManager get managers => $ShelfDatabaseManager(this);
  late final $CityTable city = $CityTable(this);
  late final $CustomerTable customer = $CustomerTable(this);
  late final $CustomerMementoTable customerMemento =
      $CustomerMementoTable(this);
  late final $InvoiceTable invoice = $InvoiceTable(this);
  late final $ProductTable product = $ProductTable(this);
  late final $ProductInvoiceTable productInvoice = $ProductInvoiceTable(this);
  late final $ProductMementoTable productMemento = $ProductMementoTable(this);
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
}

typedef $$CityTableCreateCompanionBuilder = CityCompanion Function({
  Value<int> rowId,
  required String city,
  required String department,
});
typedef $$CityTableUpdateCompanionBuilder = CityCompanion Function({
  Value<int> rowId,
  Value<String> city,
  Value<String> department,
});

final class $$CityTableReferences
    extends BaseReferences<_$ShelfDatabase, $CityTable, CityData> {
  $$CityTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CustomerTable, List<CustomerData>>
      _customerRefsTable(_$ShelfDatabase db) =>
          MultiTypedResultKey.fromTable(db.customer,
              aliasName:
                  $_aliasNameGenerator(db.city.rowId, db.customer.cityRowId));

  $$CustomerTableProcessedTableManager get customerRefs {
    final manager = $$CustomerTableTableManager($_db, $_db.customer)
        .filter((f) => f.cityRowId.rowId($_item.rowId));

    final cache = $_typedResult.readTableOrNull(_customerRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CityTableFilterComposer extends Composer<_$ShelfDatabase, $CityTable> {
  $$CityTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get rowId => $composableBuilder(
      column: $table.rowId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get city => $composableBuilder(
      column: $table.city, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get department => $composableBuilder(
      column: $table.department, builder: (column) => ColumnFilters(column));

  Expression<bool> customerRefs(
      Expression<bool> Function($$CustomerTableFilterComposer f) f) {
    final $$CustomerTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.rowId,
        referencedTable: $db.customer,
        getReferencedColumn: (t) => t.cityRowId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CustomerTableFilterComposer(
              $db: $db,
              $table: $db.customer,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CityTableOrderingComposer
    extends Composer<_$ShelfDatabase, $CityTable> {
  $$CityTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get rowId => $composableBuilder(
      column: $table.rowId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get city => $composableBuilder(
      column: $table.city, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get department => $composableBuilder(
      column: $table.department, builder: (column) => ColumnOrderings(column));
}

class $$CityTableAnnotationComposer
    extends Composer<_$ShelfDatabase, $CityTable> {
  $$CityTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get rowId =>
      $composableBuilder(column: $table.rowId, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get department => $composableBuilder(
      column: $table.department, builder: (column) => column);

  Expression<T> customerRefs<T extends Object>(
      Expression<T> Function($$CustomerTableAnnotationComposer a) f) {
    final $$CustomerTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.rowId,
        referencedTable: $db.customer,
        getReferencedColumn: (t) => t.cityRowId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CustomerTableAnnotationComposer(
              $db: $db,
              $table: $db.customer,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CityTableTableManager extends RootTableManager<
    _$ShelfDatabase,
    $CityTable,
    CityData,
    $$CityTableFilterComposer,
    $$CityTableOrderingComposer,
    $$CityTableAnnotationComposer,
    $$CityTableCreateCompanionBuilder,
    $$CityTableUpdateCompanionBuilder,
    (CityData, $$CityTableReferences),
    CityData,
    PrefetchHooks Function({bool customerRefs})> {
  $$CityTableTableManager(_$ShelfDatabase db, $CityTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CityTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CityTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CityTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> rowId = const Value.absent(),
            Value<String> city = const Value.absent(),
            Value<String> department = const Value.absent(),
          }) =>
              CityCompanion(
            rowId: rowId,
            city: city,
            department: department,
          ),
          createCompanionCallback: ({
            Value<int> rowId = const Value.absent(),
            required String city,
            required String department,
          }) =>
              CityCompanion.insert(
            rowId: rowId,
            city: city,
            department: department,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$CityTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({customerRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (customerRefs) db.customer],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (customerRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$CityTableReferences._customerRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CityTableReferences(db, table, p0).customerRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.cityRowId == item.rowId),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CityTableProcessedTableManager = ProcessedTableManager<
    _$ShelfDatabase,
    $CityTable,
    CityData,
    $$CityTableFilterComposer,
    $$CityTableOrderingComposer,
    $$CityTableAnnotationComposer,
    $$CityTableCreateCompanionBuilder,
    $$CityTableUpdateCompanionBuilder,
    (CityData, $$CityTableReferences),
    CityData,
    PrefetchHooks Function({bool customerRefs})>;
typedef $$CustomerTableCreateCompanionBuilder = CustomerCompanion Function({
  Value<String> uuid,
  required String name,
  required String phone,
  required String address,
  required int cityRowId,
  Value<String?> businessName,
  Value<int> rowid,
});
typedef $$CustomerTableUpdateCompanionBuilder = CustomerCompanion Function({
  Value<String> uuid,
  Value<String> name,
  Value<String> phone,
  Value<String> address,
  Value<int> cityRowId,
  Value<String?> businessName,
  Value<int> rowid,
});

final class $$CustomerTableReferences
    extends BaseReferences<_$ShelfDatabase, $CustomerTable, CustomerData> {
  $$CustomerTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CityTable _cityRowIdTable(_$ShelfDatabase db) => db.city
      .createAlias($_aliasNameGenerator(db.customer.cityRowId, db.city.rowId));

  $$CityTableProcessedTableManager get cityRowId {
    final manager = $$CityTableTableManager($_db, $_db.city)
        .filter((f) => f.rowId($_item.cityRowId));
    final item = $_typedResult.readTableOrNull(_cityRowIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$CustomerMementoTable, List<CustomerMementoData>>
      _customerMementoRefsTable(_$ShelfDatabase db) =>
          MultiTypedResultKey.fromTable(db.customerMemento,
              aliasName: $_aliasNameGenerator(
                  db.customer.uuid, db.customerMemento.clientUuid));

  $$CustomerMementoTableProcessedTableManager get customerMementoRefs {
    final manager =
        $$CustomerMementoTableTableManager($_db, $_db.customerMemento)
            .filter((f) => f.clientUuid.uuid($_item.uuid));

    final cache =
        $_typedResult.readTableOrNull(_customerMementoRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$InvoiceTable, List<InvoiceData>>
      _invoiceRefsTable(_$ShelfDatabase db) => MultiTypedResultKey.fromTable(
          db.invoice,
          aliasName:
              $_aliasNameGenerator(db.customer.uuid, db.invoice.customerUuid));

  $$InvoiceTableProcessedTableManager get invoiceRefs {
    final manager = $$InvoiceTableTableManager($_db, $_db.invoice)
        .filter((f) => f.customerUuid.uuid($_item.uuid));

    final cache = $_typedResult.readTableOrNull(_invoiceRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CustomerTableFilterComposer
    extends Composer<_$ShelfDatabase, $CustomerTable> {
  $$CustomerTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get businessName => $composableBuilder(
      column: $table.businessName, builder: (column) => ColumnFilters(column));

  $$CityTableFilterComposer get cityRowId {
    final $$CityTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cityRowId,
        referencedTable: $db.city,
        getReferencedColumn: (t) => t.rowId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CityTableFilterComposer(
              $db: $db,
              $table: $db.city,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> customerMementoRefs(
      Expression<bool> Function($$CustomerMementoTableFilterComposer f) f) {
    final $$CustomerMementoTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uuid,
        referencedTable: $db.customerMemento,
        getReferencedColumn: (t) => t.clientUuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CustomerMementoTableFilterComposer(
              $db: $db,
              $table: $db.customerMemento,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> invoiceRefs(
      Expression<bool> Function($$InvoiceTableFilterComposer f) f) {
    final $$InvoiceTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uuid,
        referencedTable: $db.invoice,
        getReferencedColumn: (t) => t.customerUuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$InvoiceTableFilterComposer(
              $db: $db,
              $table: $db.invoice,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CustomerTableOrderingComposer
    extends Composer<_$ShelfDatabase, $CustomerTable> {
  $$CustomerTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get businessName => $composableBuilder(
      column: $table.businessName,
      builder: (column) => ColumnOrderings(column));

  $$CityTableOrderingComposer get cityRowId {
    final $$CityTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cityRowId,
        referencedTable: $db.city,
        getReferencedColumn: (t) => t.rowId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CityTableOrderingComposer(
              $db: $db,
              $table: $db.city,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CustomerTableAnnotationComposer
    extends Composer<_$ShelfDatabase, $CustomerTable> {
  $$CustomerTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get businessName => $composableBuilder(
      column: $table.businessName, builder: (column) => column);

  $$CityTableAnnotationComposer get cityRowId {
    final $$CityTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cityRowId,
        referencedTable: $db.city,
        getReferencedColumn: (t) => t.rowId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CityTableAnnotationComposer(
              $db: $db,
              $table: $db.city,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> customerMementoRefs<T extends Object>(
      Expression<T> Function($$CustomerMementoTableAnnotationComposer a) f) {
    final $$CustomerMementoTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uuid,
        referencedTable: $db.customerMemento,
        getReferencedColumn: (t) => t.clientUuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CustomerMementoTableAnnotationComposer(
              $db: $db,
              $table: $db.customerMemento,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> invoiceRefs<T extends Object>(
      Expression<T> Function($$InvoiceTableAnnotationComposer a) f) {
    final $$InvoiceTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uuid,
        referencedTable: $db.invoice,
        getReferencedColumn: (t) => t.customerUuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$InvoiceTableAnnotationComposer(
              $db: $db,
              $table: $db.invoice,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CustomerTableTableManager extends RootTableManager<
    _$ShelfDatabase,
    $CustomerTable,
    CustomerData,
    $$CustomerTableFilterComposer,
    $$CustomerTableOrderingComposer,
    $$CustomerTableAnnotationComposer,
    $$CustomerTableCreateCompanionBuilder,
    $$CustomerTableUpdateCompanionBuilder,
    (CustomerData, $$CustomerTableReferences),
    CustomerData,
    PrefetchHooks Function(
        {bool cityRowId, bool customerMementoRefs, bool invoiceRefs})> {
  $$CustomerTableTableManager(_$ShelfDatabase db, $CustomerTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomerTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomerTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomerTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> uuid = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> phone = const Value.absent(),
            Value<String> address = const Value.absent(),
            Value<int> cityRowId = const Value.absent(),
            Value<String?> businessName = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CustomerCompanion(
            uuid: uuid,
            name: name,
            phone: phone,
            address: address,
            cityRowId: cityRowId,
            businessName: businessName,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> uuid = const Value.absent(),
            required String name,
            required String phone,
            required String address,
            required int cityRowId,
            Value<String?> businessName = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CustomerCompanion.insert(
            uuid: uuid,
            name: name,
            phone: phone,
            address: address,
            cityRowId: cityRowId,
            businessName: businessName,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$CustomerTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {cityRowId = false,
              customerMementoRefs = false,
              invoiceRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (customerMementoRefs) db.customerMemento,
                if (invoiceRefs) db.invoice
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (cityRowId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.cityRowId,
                    referencedTable:
                        $$CustomerTableReferences._cityRowIdTable(db),
                    referencedColumn:
                        $$CustomerTableReferences._cityRowIdTable(db).rowId,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (customerMementoRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$CustomerTableReferences
                            ._customerMementoRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CustomerTableReferences(db, table, p0)
                                .customerMementoRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.clientUuid == item.uuid),
                        typedResults: items),
                  if (invoiceRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$CustomerTableReferences._invoiceRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CustomerTableReferences(db, table, p0)
                                .invoiceRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.customerUuid == item.uuid),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CustomerTableProcessedTableManager = ProcessedTableManager<
    _$ShelfDatabase,
    $CustomerTable,
    CustomerData,
    $$CustomerTableFilterComposer,
    $$CustomerTableOrderingComposer,
    $$CustomerTableAnnotationComposer,
    $$CustomerTableCreateCompanionBuilder,
    $$CustomerTableUpdateCompanionBuilder,
    (CustomerData, $$CustomerTableReferences),
    CustomerData,
    PrefetchHooks Function(
        {bool cityRowId, bool customerMementoRefs, bool invoiceRefs})>;
typedef $$CustomerMementoTableCreateCompanionBuilder = CustomerMementoCompanion
    Function({
  Value<String> uuid,
  Value<DateTime> date,
  required String data,
  required int version,
  required String clientUuid,
  Value<int> rowid,
});
typedef $$CustomerMementoTableUpdateCompanionBuilder = CustomerMementoCompanion
    Function({
  Value<String> uuid,
  Value<DateTime> date,
  Value<String> data,
  Value<int> version,
  Value<String> clientUuid,
  Value<int> rowid,
});

final class $$CustomerMementoTableReferences extends BaseReferences<
    _$ShelfDatabase, $CustomerMementoTable, CustomerMementoData> {
  $$CustomerMementoTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $CustomerTable _clientUuidTable(_$ShelfDatabase db) =>
      db.customer.createAlias($_aliasNameGenerator(
          db.customerMemento.clientUuid, db.customer.uuid));

  $$CustomerTableProcessedTableManager get clientUuid {
    final manager = $$CustomerTableTableManager($_db, $_db.customer)
        .filter((f) => f.uuid($_item.clientUuid));
    final item = $_typedResult.readTableOrNull(_clientUuidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CustomerMementoTableFilterComposer
    extends Composer<_$ShelfDatabase, $CustomerMementoTable> {
  $$CustomerMementoTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get data => $composableBuilder(
      column: $table.data, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnFilters(column));

  $$CustomerTableFilterComposer get clientUuid {
    final $$CustomerTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientUuid,
        referencedTable: $db.customer,
        getReferencedColumn: (t) => t.uuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CustomerTableFilterComposer(
              $db: $db,
              $table: $db.customer,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CustomerMementoTableOrderingComposer
    extends Composer<_$ShelfDatabase, $CustomerMementoTable> {
  $$CustomerMementoTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get data => $composableBuilder(
      column: $table.data, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnOrderings(column));

  $$CustomerTableOrderingComposer get clientUuid {
    final $$CustomerTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientUuid,
        referencedTable: $db.customer,
        getReferencedColumn: (t) => t.uuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CustomerTableOrderingComposer(
              $db: $db,
              $table: $db.customer,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CustomerMementoTableAnnotationComposer
    extends Composer<_$ShelfDatabase, $CustomerMementoTable> {
  $$CustomerMementoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  $$CustomerTableAnnotationComposer get clientUuid {
    final $$CustomerTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientUuid,
        referencedTable: $db.customer,
        getReferencedColumn: (t) => t.uuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CustomerTableAnnotationComposer(
              $db: $db,
              $table: $db.customer,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CustomerMementoTableTableManager extends RootTableManager<
    _$ShelfDatabase,
    $CustomerMementoTable,
    CustomerMementoData,
    $$CustomerMementoTableFilterComposer,
    $$CustomerMementoTableOrderingComposer,
    $$CustomerMementoTableAnnotationComposer,
    $$CustomerMementoTableCreateCompanionBuilder,
    $$CustomerMementoTableUpdateCompanionBuilder,
    (CustomerMementoData, $$CustomerMementoTableReferences),
    CustomerMementoData,
    PrefetchHooks Function({bool clientUuid})> {
  $$CustomerMementoTableTableManager(
      _$ShelfDatabase db, $CustomerMementoTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomerMementoTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomerMementoTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomerMementoTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> uuid = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String> data = const Value.absent(),
            Value<int> version = const Value.absent(),
            Value<String> clientUuid = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CustomerMementoCompanion(
            uuid: uuid,
            date: date,
            data: data,
            version: version,
            clientUuid: clientUuid,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> uuid = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            required String data,
            required int version,
            required String clientUuid,
            Value<int> rowid = const Value.absent(),
          }) =>
              CustomerMementoCompanion.insert(
            uuid: uuid,
            date: date,
            data: data,
            version: version,
            clientUuid: clientUuid,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CustomerMementoTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({clientUuid = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (clientUuid) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.clientUuid,
                    referencedTable:
                        $$CustomerMementoTableReferences._clientUuidTable(db),
                    referencedColumn: $$CustomerMementoTableReferences
                        ._clientUuidTable(db)
                        .uuid,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$CustomerMementoTableProcessedTableManager = ProcessedTableManager<
    _$ShelfDatabase,
    $CustomerMementoTable,
    CustomerMementoData,
    $$CustomerMementoTableFilterComposer,
    $$CustomerMementoTableOrderingComposer,
    $$CustomerMementoTableAnnotationComposer,
    $$CustomerMementoTableCreateCompanionBuilder,
    $$CustomerMementoTableUpdateCompanionBuilder,
    (CustomerMementoData, $$CustomerMementoTableReferences),
    CustomerMementoData,
    PrefetchHooks Function({bool clientUuid})>;
typedef $$InvoiceTableCreateCompanionBuilder = InvoiceCompanion Function({
  Value<String> uuid,
  required int number,
  Value<DateTime> date,
  Value<int> discount,
  required String customerUuid,
  Value<int> rowid,
});
typedef $$InvoiceTableUpdateCompanionBuilder = InvoiceCompanion Function({
  Value<String> uuid,
  Value<int> number,
  Value<DateTime> date,
  Value<int> discount,
  Value<String> customerUuid,
  Value<int> rowid,
});

final class $$InvoiceTableReferences
    extends BaseReferences<_$ShelfDatabase, $InvoiceTable, InvoiceData> {
  $$InvoiceTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CustomerTable _customerUuidTable(_$ShelfDatabase db) =>
      db.customer.createAlias(
          $_aliasNameGenerator(db.invoice.customerUuid, db.customer.uuid));

  $$CustomerTableProcessedTableManager get customerUuid {
    final manager = $$CustomerTableTableManager($_db, $_db.customer)
        .filter((f) => f.uuid($_item.customerUuid));
    final item = $_typedResult.readTableOrNull(_customerUuidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ProductInvoiceTable, List<ProductInvoiceData>>
      _productInvoiceRefsTable(_$ShelfDatabase db) =>
          MultiTypedResultKey.fromTable(db.productInvoice,
              aliasName: $_aliasNameGenerator(
                  db.invoice.uuid, db.productInvoice.invoiceUuid));

  $$ProductInvoiceTableProcessedTableManager get productInvoiceRefs {
    final manager = $$ProductInvoiceTableTableManager($_db, $_db.productInvoice)
        .filter((f) => f.invoiceUuid.uuid($_item.uuid));

    final cache = $_typedResult.readTableOrNull(_productInvoiceRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$InvoiceTableFilterComposer
    extends Composer<_$ShelfDatabase, $InvoiceTable> {
  $$InvoiceTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get number => $composableBuilder(
      column: $table.number, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get discount => $composableBuilder(
      column: $table.discount, builder: (column) => ColumnFilters(column));

  $$CustomerTableFilterComposer get customerUuid {
    final $$CustomerTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerUuid,
        referencedTable: $db.customer,
        getReferencedColumn: (t) => t.uuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CustomerTableFilterComposer(
              $db: $db,
              $table: $db.customer,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> productInvoiceRefs(
      Expression<bool> Function($$ProductInvoiceTableFilterComposer f) f) {
    final $$ProductInvoiceTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uuid,
        referencedTable: $db.productInvoice,
        getReferencedColumn: (t) => t.invoiceUuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductInvoiceTableFilterComposer(
              $db: $db,
              $table: $db.productInvoice,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$InvoiceTableOrderingComposer
    extends Composer<_$ShelfDatabase, $InvoiceTable> {
  $$InvoiceTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get number => $composableBuilder(
      column: $table.number, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get discount => $composableBuilder(
      column: $table.discount, builder: (column) => ColumnOrderings(column));

  $$CustomerTableOrderingComposer get customerUuid {
    final $$CustomerTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerUuid,
        referencedTable: $db.customer,
        getReferencedColumn: (t) => t.uuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CustomerTableOrderingComposer(
              $db: $db,
              $table: $db.customer,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$InvoiceTableAnnotationComposer
    extends Composer<_$ShelfDatabase, $InvoiceTable> {
  $$InvoiceTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<int> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get discount =>
      $composableBuilder(column: $table.discount, builder: (column) => column);

  $$CustomerTableAnnotationComposer get customerUuid {
    final $$CustomerTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerUuid,
        referencedTable: $db.customer,
        getReferencedColumn: (t) => t.uuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CustomerTableAnnotationComposer(
              $db: $db,
              $table: $db.customer,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> productInvoiceRefs<T extends Object>(
      Expression<T> Function($$ProductInvoiceTableAnnotationComposer a) f) {
    final $$ProductInvoiceTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uuid,
        referencedTable: $db.productInvoice,
        getReferencedColumn: (t) => t.invoiceUuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductInvoiceTableAnnotationComposer(
              $db: $db,
              $table: $db.productInvoice,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$InvoiceTableTableManager extends RootTableManager<
    _$ShelfDatabase,
    $InvoiceTable,
    InvoiceData,
    $$InvoiceTableFilterComposer,
    $$InvoiceTableOrderingComposer,
    $$InvoiceTableAnnotationComposer,
    $$InvoiceTableCreateCompanionBuilder,
    $$InvoiceTableUpdateCompanionBuilder,
    (InvoiceData, $$InvoiceTableReferences),
    InvoiceData,
    PrefetchHooks Function({bool customerUuid, bool productInvoiceRefs})> {
  $$InvoiceTableTableManager(_$ShelfDatabase db, $InvoiceTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoiceTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoiceTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoiceTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> uuid = const Value.absent(),
            Value<int> number = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<int> discount = const Value.absent(),
            Value<String> customerUuid = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              InvoiceCompanion(
            uuid: uuid,
            number: number,
            date: date,
            discount: discount,
            customerUuid: customerUuid,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> uuid = const Value.absent(),
            required int number,
            Value<DateTime> date = const Value.absent(),
            Value<int> discount = const Value.absent(),
            required String customerUuid,
            Value<int> rowid = const Value.absent(),
          }) =>
              InvoiceCompanion.insert(
            uuid: uuid,
            number: number,
            date: date,
            discount: discount,
            customerUuid: customerUuid,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$InvoiceTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {customerUuid = false, productInvoiceRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (productInvoiceRefs) db.productInvoice
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (customerUuid) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.customerUuid,
                    referencedTable:
                        $$InvoiceTableReferences._customerUuidTable(db),
                    referencedColumn:
                        $$InvoiceTableReferences._customerUuidTable(db).uuid,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (productInvoiceRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$InvoiceTableReferences
                            ._productInvoiceRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$InvoiceTableReferences(db, table, p0)
                                .productInvoiceRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.invoiceUuid == item.uuid),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$InvoiceTableProcessedTableManager = ProcessedTableManager<
    _$ShelfDatabase,
    $InvoiceTable,
    InvoiceData,
    $$InvoiceTableFilterComposer,
    $$InvoiceTableOrderingComposer,
    $$InvoiceTableAnnotationComposer,
    $$InvoiceTableCreateCompanionBuilder,
    $$InvoiceTableUpdateCompanionBuilder,
    (InvoiceData, $$InvoiceTableReferences),
    InvoiceData,
    PrefetchHooks Function({bool customerUuid, bool productInvoiceRefs})>;
typedef $$ProductTableCreateCompanionBuilder = ProductCompanion Function({
  Value<String> uuid,
  required String name,
  required BigInt price,
  required int stock,
  Value<String?> code,
  Value<int> rowid,
});
typedef $$ProductTableUpdateCompanionBuilder = ProductCompanion Function({
  Value<String> uuid,
  Value<String> name,
  Value<BigInt> price,
  Value<int> stock,
  Value<String?> code,
  Value<int> rowid,
});

final class $$ProductTableReferences
    extends BaseReferences<_$ShelfDatabase, $ProductTable, ProductData> {
  $$ProductTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProductInvoiceTable, List<ProductInvoiceData>>
      _productInvoiceRefsTable(_$ShelfDatabase db) =>
          MultiTypedResultKey.fromTable(db.productInvoice,
              aliasName: $_aliasNameGenerator(
                  db.product.uuid, db.productInvoice.productUuid));

  $$ProductInvoiceTableProcessedTableManager get productInvoiceRefs {
    final manager = $$ProductInvoiceTableTableManager($_db, $_db.productInvoice)
        .filter((f) => f.productUuid.uuid($_item.uuid));

    final cache = $_typedResult.readTableOrNull(_productInvoiceRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ProductMementoTable, List<ProductMementoData>>
      _productMementoRefsTable(_$ShelfDatabase db) =>
          MultiTypedResultKey.fromTable(db.productMemento,
              aliasName: $_aliasNameGenerator(
                  db.product.uuid, db.productMemento.productUuid));

  $$ProductMementoTableProcessedTableManager get productMementoRefs {
    final manager = $$ProductMementoTableTableManager($_db, $_db.productMemento)
        .filter((f) => f.productUuid.uuid($_item.uuid));

    final cache = $_typedResult.readTableOrNull(_productMementoRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ProductTableFilterComposer
    extends Composer<_$ShelfDatabase, $ProductTable> {
  $$ProductTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<BigInt> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get stock => $composableBuilder(
      column: $table.stock, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  Expression<bool> productInvoiceRefs(
      Expression<bool> Function($$ProductInvoiceTableFilterComposer f) f) {
    final $$ProductInvoiceTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uuid,
        referencedTable: $db.productInvoice,
        getReferencedColumn: (t) => t.productUuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductInvoiceTableFilterComposer(
              $db: $db,
              $table: $db.productInvoice,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> productMementoRefs(
      Expression<bool> Function($$ProductMementoTableFilterComposer f) f) {
    final $$ProductMementoTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uuid,
        referencedTable: $db.productMemento,
        getReferencedColumn: (t) => t.productUuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductMementoTableFilterComposer(
              $db: $db,
              $table: $db.productMemento,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProductTableOrderingComposer
    extends Composer<_$ShelfDatabase, $ProductTable> {
  $$ProductTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<BigInt> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get stock => $composableBuilder(
      column: $table.stock, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));
}

class $$ProductTableAnnotationComposer
    extends Composer<_$ShelfDatabase, $ProductTable> {
  $$ProductTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<BigInt> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<int> get stock =>
      $composableBuilder(column: $table.stock, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  Expression<T> productInvoiceRefs<T extends Object>(
      Expression<T> Function($$ProductInvoiceTableAnnotationComposer a) f) {
    final $$ProductInvoiceTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uuid,
        referencedTable: $db.productInvoice,
        getReferencedColumn: (t) => t.productUuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductInvoiceTableAnnotationComposer(
              $db: $db,
              $table: $db.productInvoice,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> productMementoRefs<T extends Object>(
      Expression<T> Function($$ProductMementoTableAnnotationComposer a) f) {
    final $$ProductMementoTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uuid,
        referencedTable: $db.productMemento,
        getReferencedColumn: (t) => t.productUuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductMementoTableAnnotationComposer(
              $db: $db,
              $table: $db.productMemento,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProductTableTableManager extends RootTableManager<
    _$ShelfDatabase,
    $ProductTable,
    ProductData,
    $$ProductTableFilterComposer,
    $$ProductTableOrderingComposer,
    $$ProductTableAnnotationComposer,
    $$ProductTableCreateCompanionBuilder,
    $$ProductTableUpdateCompanionBuilder,
    (ProductData, $$ProductTableReferences),
    ProductData,
    PrefetchHooks Function(
        {bool productInvoiceRefs, bool productMementoRefs})> {
  $$ProductTableTableManager(_$ShelfDatabase db, $ProductTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> uuid = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<BigInt> price = const Value.absent(),
            Value<int> stock = const Value.absent(),
            Value<String?> code = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductCompanion(
            uuid: uuid,
            name: name,
            price: price,
            stock: stock,
            code: code,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> uuid = const Value.absent(),
            required String name,
            required BigInt price,
            required int stock,
            Value<String?> code = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductCompanion.insert(
            uuid: uuid,
            name: name,
            price: price,
            stock: stock,
            code: code,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ProductTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {productInvoiceRefs = false, productMementoRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (productInvoiceRefs) db.productInvoice,
                if (productMementoRefs) db.productMemento
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (productInvoiceRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ProductTableReferences
                            ._productInvoiceRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProductTableReferences(db, table, p0)
                                .productInvoiceRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.productUuid == item.uuid),
                        typedResults: items),
                  if (productMementoRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ProductTableReferences
                            ._productMementoRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProductTableReferences(db, table, p0)
                                .productMementoRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.productUuid == item.uuid),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ProductTableProcessedTableManager = ProcessedTableManager<
    _$ShelfDatabase,
    $ProductTable,
    ProductData,
    $$ProductTableFilterComposer,
    $$ProductTableOrderingComposer,
    $$ProductTableAnnotationComposer,
    $$ProductTableCreateCompanionBuilder,
    $$ProductTableUpdateCompanionBuilder,
    (ProductData, $$ProductTableReferences),
    ProductData,
    PrefetchHooks Function({bool productInvoiceRefs, bool productMementoRefs})>;
typedef $$ProductInvoiceTableCreateCompanionBuilder = ProductInvoiceCompanion
    Function({
  required int price,
  required int count,
  Value<int> discount,
  required String productUuid,
  required String invoiceUuid,
  Value<int> rowid,
});
typedef $$ProductInvoiceTableUpdateCompanionBuilder = ProductInvoiceCompanion
    Function({
  Value<int> price,
  Value<int> count,
  Value<int> discount,
  Value<String> productUuid,
  Value<String> invoiceUuid,
  Value<int> rowid,
});

final class $$ProductInvoiceTableReferences extends BaseReferences<
    _$ShelfDatabase, $ProductInvoiceTable, ProductInvoiceData> {
  $$ProductInvoiceTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ProductTable _productUuidTable(_$ShelfDatabase db) =>
      db.product.createAlias(
          $_aliasNameGenerator(db.productInvoice.productUuid, db.product.uuid));

  $$ProductTableProcessedTableManager get productUuid {
    final manager = $$ProductTableTableManager($_db, $_db.product)
        .filter((f) => f.uuid($_item.productUuid));
    final item = $_typedResult.readTableOrNull(_productUuidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $InvoiceTable _invoiceUuidTable(_$ShelfDatabase db) =>
      db.invoice.createAlias(
          $_aliasNameGenerator(db.productInvoice.invoiceUuid, db.invoice.uuid));

  $$InvoiceTableProcessedTableManager get invoiceUuid {
    final manager = $$InvoiceTableTableManager($_db, $_db.invoice)
        .filter((f) => f.uuid($_item.invoiceUuid));
    final item = $_typedResult.readTableOrNull(_invoiceUuidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ProductInvoiceTableFilterComposer
    extends Composer<_$ShelfDatabase, $ProductInvoiceTable> {
  $$ProductInvoiceTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get count => $composableBuilder(
      column: $table.count, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get discount => $composableBuilder(
      column: $table.discount, builder: (column) => ColumnFilters(column));

  $$ProductTableFilterComposer get productUuid {
    final $$ProductTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productUuid,
        referencedTable: $db.product,
        getReferencedColumn: (t) => t.uuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductTableFilterComposer(
              $db: $db,
              $table: $db.product,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$InvoiceTableFilterComposer get invoiceUuid {
    final $$InvoiceTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.invoiceUuid,
        referencedTable: $db.invoice,
        getReferencedColumn: (t) => t.uuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$InvoiceTableFilterComposer(
              $db: $db,
              $table: $db.invoice,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProductInvoiceTableOrderingComposer
    extends Composer<_$ShelfDatabase, $ProductInvoiceTable> {
  $$ProductInvoiceTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get count => $composableBuilder(
      column: $table.count, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get discount => $composableBuilder(
      column: $table.discount, builder: (column) => ColumnOrderings(column));

  $$ProductTableOrderingComposer get productUuid {
    final $$ProductTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productUuid,
        referencedTable: $db.product,
        getReferencedColumn: (t) => t.uuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductTableOrderingComposer(
              $db: $db,
              $table: $db.product,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$InvoiceTableOrderingComposer get invoiceUuid {
    final $$InvoiceTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.invoiceUuid,
        referencedTable: $db.invoice,
        getReferencedColumn: (t) => t.uuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$InvoiceTableOrderingComposer(
              $db: $db,
              $table: $db.invoice,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProductInvoiceTableAnnotationComposer
    extends Composer<_$ShelfDatabase, $ProductInvoiceTable> {
  $$ProductInvoiceTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<int> get count =>
      $composableBuilder(column: $table.count, builder: (column) => column);

  GeneratedColumn<int> get discount =>
      $composableBuilder(column: $table.discount, builder: (column) => column);

  $$ProductTableAnnotationComposer get productUuid {
    final $$ProductTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productUuid,
        referencedTable: $db.product,
        getReferencedColumn: (t) => t.uuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductTableAnnotationComposer(
              $db: $db,
              $table: $db.product,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$InvoiceTableAnnotationComposer get invoiceUuid {
    final $$InvoiceTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.invoiceUuid,
        referencedTable: $db.invoice,
        getReferencedColumn: (t) => t.uuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$InvoiceTableAnnotationComposer(
              $db: $db,
              $table: $db.invoice,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProductInvoiceTableTableManager extends RootTableManager<
    _$ShelfDatabase,
    $ProductInvoiceTable,
    ProductInvoiceData,
    $$ProductInvoiceTableFilterComposer,
    $$ProductInvoiceTableOrderingComposer,
    $$ProductInvoiceTableAnnotationComposer,
    $$ProductInvoiceTableCreateCompanionBuilder,
    $$ProductInvoiceTableUpdateCompanionBuilder,
    (ProductInvoiceData, $$ProductInvoiceTableReferences),
    ProductInvoiceData,
    PrefetchHooks Function({bool productUuid, bool invoiceUuid})> {
  $$ProductInvoiceTableTableManager(
      _$ShelfDatabase db, $ProductInvoiceTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductInvoiceTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductInvoiceTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductInvoiceTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> price = const Value.absent(),
            Value<int> count = const Value.absent(),
            Value<int> discount = const Value.absent(),
            Value<String> productUuid = const Value.absent(),
            Value<String> invoiceUuid = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductInvoiceCompanion(
            price: price,
            count: count,
            discount: discount,
            productUuid: productUuid,
            invoiceUuid: invoiceUuid,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int price,
            required int count,
            Value<int> discount = const Value.absent(),
            required String productUuid,
            required String invoiceUuid,
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductInvoiceCompanion.insert(
            price: price,
            count: count,
            discount: discount,
            productUuid: productUuid,
            invoiceUuid: invoiceUuid,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ProductInvoiceTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({productUuid = false, invoiceUuid = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (productUuid) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.productUuid,
                    referencedTable:
                        $$ProductInvoiceTableReferences._productUuidTable(db),
                    referencedColumn: $$ProductInvoiceTableReferences
                        ._productUuidTable(db)
                        .uuid,
                  ) as T;
                }
                if (invoiceUuid) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.invoiceUuid,
                    referencedTable:
                        $$ProductInvoiceTableReferences._invoiceUuidTable(db),
                    referencedColumn: $$ProductInvoiceTableReferences
                        ._invoiceUuidTable(db)
                        .uuid,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ProductInvoiceTableProcessedTableManager = ProcessedTableManager<
    _$ShelfDatabase,
    $ProductInvoiceTable,
    ProductInvoiceData,
    $$ProductInvoiceTableFilterComposer,
    $$ProductInvoiceTableOrderingComposer,
    $$ProductInvoiceTableAnnotationComposer,
    $$ProductInvoiceTableCreateCompanionBuilder,
    $$ProductInvoiceTableUpdateCompanionBuilder,
    (ProductInvoiceData, $$ProductInvoiceTableReferences),
    ProductInvoiceData,
    PrefetchHooks Function({bool productUuid, bool invoiceUuid})>;
typedef $$ProductMementoTableCreateCompanionBuilder = ProductMementoCompanion
    Function({
  Value<String> uuid,
  Value<DateTime> date,
  required String data,
  required int version,
  required String productUuid,
  Value<int> rowid,
});
typedef $$ProductMementoTableUpdateCompanionBuilder = ProductMementoCompanion
    Function({
  Value<String> uuid,
  Value<DateTime> date,
  Value<String> data,
  Value<int> version,
  Value<String> productUuid,
  Value<int> rowid,
});

final class $$ProductMementoTableReferences extends BaseReferences<
    _$ShelfDatabase, $ProductMementoTable, ProductMementoData> {
  $$ProductMementoTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ProductTable _productUuidTable(_$ShelfDatabase db) =>
      db.product.createAlias(
          $_aliasNameGenerator(db.productMemento.productUuid, db.product.uuid));

  $$ProductTableProcessedTableManager get productUuid {
    final manager = $$ProductTableTableManager($_db, $_db.product)
        .filter((f) => f.uuid($_item.productUuid));
    final item = $_typedResult.readTableOrNull(_productUuidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ProductMementoTableFilterComposer
    extends Composer<_$ShelfDatabase, $ProductMementoTable> {
  $$ProductMementoTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get data => $composableBuilder(
      column: $table.data, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnFilters(column));

  $$ProductTableFilterComposer get productUuid {
    final $$ProductTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productUuid,
        referencedTable: $db.product,
        getReferencedColumn: (t) => t.uuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductTableFilterComposer(
              $db: $db,
              $table: $db.product,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProductMementoTableOrderingComposer
    extends Composer<_$ShelfDatabase, $ProductMementoTable> {
  $$ProductMementoTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get data => $composableBuilder(
      column: $table.data, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnOrderings(column));

  $$ProductTableOrderingComposer get productUuid {
    final $$ProductTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productUuid,
        referencedTable: $db.product,
        getReferencedColumn: (t) => t.uuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductTableOrderingComposer(
              $db: $db,
              $table: $db.product,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProductMementoTableAnnotationComposer
    extends Composer<_$ShelfDatabase, $ProductMementoTable> {
  $$ProductMementoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  $$ProductTableAnnotationComposer get productUuid {
    final $$ProductTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productUuid,
        referencedTable: $db.product,
        getReferencedColumn: (t) => t.uuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProductTableAnnotationComposer(
              $db: $db,
              $table: $db.product,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProductMementoTableTableManager extends RootTableManager<
    _$ShelfDatabase,
    $ProductMementoTable,
    ProductMementoData,
    $$ProductMementoTableFilterComposer,
    $$ProductMementoTableOrderingComposer,
    $$ProductMementoTableAnnotationComposer,
    $$ProductMementoTableCreateCompanionBuilder,
    $$ProductMementoTableUpdateCompanionBuilder,
    (ProductMementoData, $$ProductMementoTableReferences),
    ProductMementoData,
    PrefetchHooks Function({bool productUuid})> {
  $$ProductMementoTableTableManager(
      _$ShelfDatabase db, $ProductMementoTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductMementoTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductMementoTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductMementoTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> uuid = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String> data = const Value.absent(),
            Value<int> version = const Value.absent(),
            Value<String> productUuid = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductMementoCompanion(
            uuid: uuid,
            date: date,
            data: data,
            version: version,
            productUuid: productUuid,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> uuid = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            required String data,
            required int version,
            required String productUuid,
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductMementoCompanion.insert(
            uuid: uuid,
            date: date,
            data: data,
            version: version,
            productUuid: productUuid,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ProductMementoTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({productUuid = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (productUuid) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.productUuid,
                    referencedTable:
                        $$ProductMementoTableReferences._productUuidTable(db),
                    referencedColumn: $$ProductMementoTableReferences
                        ._productUuidTable(db)
                        .uuid,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ProductMementoTableProcessedTableManager = ProcessedTableManager<
    _$ShelfDatabase,
    $ProductMementoTable,
    ProductMementoData,
    $$ProductMementoTableFilterComposer,
    $$ProductMementoTableOrderingComposer,
    $$ProductMementoTableAnnotationComposer,
    $$ProductMementoTableCreateCompanionBuilder,
    $$ProductMementoTableUpdateCompanionBuilder,
    (ProductMementoData, $$ProductMementoTableReferences),
    ProductMementoData,
    PrefetchHooks Function({bool productUuid})>;

class $ShelfDatabaseManager {
  final _$ShelfDatabase _db;
  $ShelfDatabaseManager(this._db);
  $$CityTableTableManager get city => $$CityTableTableManager(_db, _db.city);
  $$CustomerTableTableManager get customer =>
      $$CustomerTableTableManager(_db, _db.customer);
  $$CustomerMementoTableTableManager get customerMemento =>
      $$CustomerMementoTableTableManager(_db, _db.customerMemento);
  $$InvoiceTableTableManager get invoice =>
      $$InvoiceTableTableManager(_db, _db.invoice);
  $$ProductTableTableManager get product =>
      $$ProductTableTableManager(_db, _db.product);
  $$ProductInvoiceTableTableManager get productInvoice =>
      $$ProductInvoiceTableTableManager(_db, _db.productInvoice);
  $$ProductMementoTableTableManager get productMemento =>
      $$ProductMementoTableTableManager(_db, _db.productMemento);
}
