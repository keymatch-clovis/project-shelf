// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class Product extends Table with TableInfo<Product, ProductData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Product(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  late final GeneratedColumn<int> value = GeneratedColumn<int>(
      'value', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  late final GeneratedColumn<int> stock = GeneratedColumn<int>(
      'stock', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [id, name, value, stock, code];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}value'])!,
      stock: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stock'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code']),
    );
  }

  @override
  Product createAlias(String alias) {
    return Product(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class ProductData extends DataClass implements Insertable<ProductData> {
  final String id;
  final String name;
  final int value;
  final int stock;
  final String? code;
  const ProductData(
      {required this.id,
      required this.name,
      required this.value,
      required this.stock,
      this.code});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['value'] = Variable<int>(value);
    map['stock'] = Variable<int>(stock);
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    return map;
  }

  ProductCompanion toCompanion(bool nullToAbsent) {
    return ProductCompanion(
      id: Value(id),
      name: Value(name),
      value: Value(value),
      stock: Value(stock),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
    );
  }

  factory ProductData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      value: serializer.fromJson<int>(json['value']),
      stock: serializer.fromJson<int>(json['stock']),
      code: serializer.fromJson<String?>(json['code']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'value': serializer.toJson<int>(value),
      'stock': serializer.toJson<int>(stock),
      'code': serializer.toJson<String?>(code),
    };
  }

  ProductData copyWith(
          {String? id,
          String? name,
          int? value,
          int? stock,
          Value<String?> code = const Value.absent()}) =>
      ProductData(
        id: id ?? this.id,
        name: name ?? this.name,
        value: value ?? this.value,
        stock: stock ?? this.stock,
        code: code.present ? code.value : this.code,
      );
  ProductData copyWithCompanion(ProductCompanion data) {
    return ProductData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      value: data.value.present ? data.value.value : this.value,
      stock: data.stock.present ? data.stock.value : this.stock,
      code: data.code.present ? data.code.value : this.code,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('value: $value, ')
          ..write('stock: $stock, ')
          ..write('code: $code')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, value, stock, code);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductData &&
          other.id == this.id &&
          other.name == this.name &&
          other.value == this.value &&
          other.stock == this.stock &&
          other.code == this.code);
}

class ProductCompanion extends UpdateCompanion<ProductData> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> value;
  final Value<int> stock;
  final Value<String?> code;
  final Value<int> rowid;
  const ProductCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.value = const Value.absent(),
    this.stock = const Value.absent(),
    this.code = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductCompanion.insert({
    required String id,
    required String name,
    required int value,
    required int stock,
    this.code = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        value = Value(value),
        stock = Value(stock);
  static Insertable<ProductData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? value,
    Expression<int>? stock,
    Expression<String>? code,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (value != null) 'value': value,
      if (stock != null) 'stock': stock,
      if (code != null) 'code': code,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<int>? value,
      Value<int>? stock,
      Value<String?>? code,
      Value<int>? rowid}) {
    return ProductCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      value: value ?? this.value,
      stock: stock ?? this.stock,
      code: code ?? this.code,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (value.present) {
      map['value'] = Variable<int>(value.value);
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
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('value: $value, ')
          ..write('stock: $stock, ')
          ..write('code: $code, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Client extends Table with TableInfo<Client, ClientData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Client(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  late final GeneratedColumn<String> document = GeneratedColumn<String>(
      'document', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [id, name, document];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'client';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ClientData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClientData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      document: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}document'])!,
    );
  }

  @override
  Client createAlias(String alias) {
    return Client(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class ClientData extends DataClass implements Insertable<ClientData> {
  final String id;
  final String name;
  final String document;
  const ClientData(
      {required this.id, required this.name, required this.document});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['document'] = Variable<String>(document);
    return map;
  }

  ClientCompanion toCompanion(bool nullToAbsent) {
    return ClientCompanion(
      id: Value(id),
      name: Value(name),
      document: Value(document),
    );
  }

  factory ClientData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClientData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      document: serializer.fromJson<String>(json['document']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'document': serializer.toJson<String>(document),
    };
  }

  ClientData copyWith({String? id, String? name, String? document}) =>
      ClientData(
        id: id ?? this.id,
        name: name ?? this.name,
        document: document ?? this.document,
      );
  ClientData copyWithCompanion(ClientCompanion data) {
    return ClientData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      document: data.document.present ? data.document.value : this.document,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClientData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('document: $document')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, document);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClientData &&
          other.id == this.id &&
          other.name == this.name &&
          other.document == this.document);
}

class ClientCompanion extends UpdateCompanion<ClientData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> document;
  final Value<int> rowid;
  const ClientCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.document = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClientCompanion.insert({
    required String id,
    required String name,
    required String document,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        document = Value(document);
  static Insertable<ClientData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? document,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (document != null) 'document': document,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClientCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? document,
      Value<int>? rowid}) {
    return ClientCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      document: document ?? this.document,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (document.present) {
      map['document'] = Variable<String>(document.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('document: $document, ')
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
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  late final GeneratedColumn<int> number = GeneratedColumn<int>(
      'number', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [id, number, date];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoice';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InvoiceData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvoiceData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      number: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}number'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
    );
  }

  @override
  Invoice createAlias(String alias) {
    return Invoice(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class InvoiceData extends DataClass implements Insertable<InvoiceData> {
  final String id;
  final int number;
  final String date;
  const InvoiceData(
      {required this.id, required this.number, required this.date});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['number'] = Variable<int>(number);
    map['date'] = Variable<String>(date);
    return map;
  }

  InvoiceCompanion toCompanion(bool nullToAbsent) {
    return InvoiceCompanion(
      id: Value(id),
      number: Value(number),
      date: Value(date),
    );
  }

  factory InvoiceData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvoiceData(
      id: serializer.fromJson<String>(json['id']),
      number: serializer.fromJson<int>(json['number']),
      date: serializer.fromJson<String>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'number': serializer.toJson<int>(number),
      'date': serializer.toJson<String>(date),
    };
  }

  InvoiceData copyWith({String? id, int? number, String? date}) => InvoiceData(
        id: id ?? this.id,
        number: number ?? this.number,
        date: date ?? this.date,
      );
  InvoiceData copyWithCompanion(InvoiceCompanion data) {
    return InvoiceData(
      id: data.id.present ? data.id.value : this.id,
      number: data.number.present ? data.number.value : this.number,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceData(')
          ..write('id: $id, ')
          ..write('number: $number, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, number, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvoiceData &&
          other.id == this.id &&
          other.number == this.number &&
          other.date == this.date);
}

class InvoiceCompanion extends UpdateCompanion<InvoiceData> {
  final Value<String> id;
  final Value<int> number;
  final Value<String> date;
  final Value<int> rowid;
  const InvoiceCompanion({
    this.id = const Value.absent(),
    this.number = const Value.absent(),
    this.date = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InvoiceCompanion.insert({
    required String id,
    required int number,
    required String date,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        number = Value(number),
        date = Value(date);
  static Insertable<InvoiceData> custom({
    Expression<String>? id,
    Expression<int>? number,
    Expression<String>? date,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (number != null) 'number': number,
      if (date != null) 'date': date,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InvoiceCompanion copyWith(
      {Value<String>? id,
      Value<int>? number,
      Value<String>? date,
      Value<int>? rowid}) {
    return InvoiceCompanion(
      id: id ?? this.id,
      number: number ?? this.number,
      date: date ?? this.date,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (number.present) {
      map['number'] = Variable<int>(number.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceCompanion(')
          ..write('id: $id, ')
          ..write('number: $number, ')
          ..write('date: $date, ')
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
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
      'product_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  late final GeneratedColumn<String> invoiceId = GeneratedColumn<String>(
      'invoice_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  late final GeneratedColumn<int> value = GeneratedColumn<int>(
      'value', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  late final GeneratedColumn<int> count = GeneratedColumn<int>(
      'count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [productId, invoiceId, value, count];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_invoice';
  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  ProductInvoiceData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductInvoiceData(
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_id'])!,
      invoiceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}invoice_id'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}value'])!,
      count: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}count'])!,
    );
  }

  @override
  ProductInvoice createAlias(String alias) {
    return ProductInvoice(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(product_id)REFERENCES product(id)',
        'FOREIGN KEY(invoice_id)REFERENCES invoice(id)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class ProductInvoiceData extends DataClass
    implements Insertable<ProductInvoiceData> {
  final String productId;
  final String invoiceId;
  final int value;
  final int count;
  const ProductInvoiceData(
      {required this.productId,
      required this.invoiceId,
      required this.value,
      required this.count});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['product_id'] = Variable<String>(productId);
    map['invoice_id'] = Variable<String>(invoiceId);
    map['value'] = Variable<int>(value);
    map['count'] = Variable<int>(count);
    return map;
  }

  ProductInvoiceCompanion toCompanion(bool nullToAbsent) {
    return ProductInvoiceCompanion(
      productId: Value(productId),
      invoiceId: Value(invoiceId),
      value: Value(value),
      count: Value(count),
    );
  }

  factory ProductInvoiceData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductInvoiceData(
      productId: serializer.fromJson<String>(json['product_id']),
      invoiceId: serializer.fromJson<String>(json['invoice_id']),
      value: serializer.fromJson<int>(json['value']),
      count: serializer.fromJson<int>(json['count']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'product_id': serializer.toJson<String>(productId),
      'invoice_id': serializer.toJson<String>(invoiceId),
      'value': serializer.toJson<int>(value),
      'count': serializer.toJson<int>(count),
    };
  }

  ProductInvoiceData copyWith(
          {String? productId, String? invoiceId, int? value, int? count}) =>
      ProductInvoiceData(
        productId: productId ?? this.productId,
        invoiceId: invoiceId ?? this.invoiceId,
        value: value ?? this.value,
        count: count ?? this.count,
      );
  ProductInvoiceData copyWithCompanion(ProductInvoiceCompanion data) {
    return ProductInvoiceData(
      productId: data.productId.present ? data.productId.value : this.productId,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      value: data.value.present ? data.value.value : this.value,
      count: data.count.present ? data.count.value : this.count,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductInvoiceData(')
          ..write('productId: $productId, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('value: $value, ')
          ..write('count: $count')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(productId, invoiceId, value, count);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductInvoiceData &&
          other.productId == this.productId &&
          other.invoiceId == this.invoiceId &&
          other.value == this.value &&
          other.count == this.count);
}

class ProductInvoiceCompanion extends UpdateCompanion<ProductInvoiceData> {
  final Value<String> productId;
  final Value<String> invoiceId;
  final Value<int> value;
  final Value<int> count;
  final Value<int> rowid;
  const ProductInvoiceCompanion({
    this.productId = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.value = const Value.absent(),
    this.count = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductInvoiceCompanion.insert({
    required String productId,
    required String invoiceId,
    required int value,
    required int count,
    this.rowid = const Value.absent(),
  })  : productId = Value(productId),
        invoiceId = Value(invoiceId),
        value = Value(value),
        count = Value(count);
  static Insertable<ProductInvoiceData> custom({
    Expression<String>? productId,
    Expression<String>? invoiceId,
    Expression<int>? value,
    Expression<int>? count,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (productId != null) 'product_id': productId,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (value != null) 'value': value,
      if (count != null) 'count': count,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductInvoiceCompanion copyWith(
      {Value<String>? productId,
      Value<String>? invoiceId,
      Value<int>? value,
      Value<int>? count,
      Value<int>? rowid}) {
    return ProductInvoiceCompanion(
      productId: productId ?? this.productId,
      invoiceId: invoiceId ?? this.invoiceId,
      value: value ?? this.value,
      count: count ?? this.count,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<String>(invoiceId.value);
    }
    if (value.present) {
      map['value'] = Variable<int>(value.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductInvoiceCompanion(')
          ..write('productId: $productId, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('value: $value, ')
          ..write('count: $count, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class ClientInvoice extends Table
    with TableInfo<ClientInvoice, ClientInvoiceData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ClientInvoice(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
      'client_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  late final GeneratedColumn<String> invoiceId = GeneratedColumn<String>(
      'invoice_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [clientId, invoiceId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'client_invoice';
  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  ClientInvoiceData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClientInvoiceData(
      clientId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}client_id'])!,
      invoiceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}invoice_id'])!,
    );
  }

  @override
  ClientInvoice createAlias(String alias) {
    return ClientInvoice(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(client_id)REFERENCES client(id)',
        'FOREIGN KEY(invoice_id)REFERENCES invoice(id)'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class ClientInvoiceData extends DataClass
    implements Insertable<ClientInvoiceData> {
  final String clientId;
  final String invoiceId;
  const ClientInvoiceData({required this.clientId, required this.invoiceId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['client_id'] = Variable<String>(clientId);
    map['invoice_id'] = Variable<String>(invoiceId);
    return map;
  }

  ClientInvoiceCompanion toCompanion(bool nullToAbsent) {
    return ClientInvoiceCompanion(
      clientId: Value(clientId),
      invoiceId: Value(invoiceId),
    );
  }

  factory ClientInvoiceData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClientInvoiceData(
      clientId: serializer.fromJson<String>(json['client_id']),
      invoiceId: serializer.fromJson<String>(json['invoice_id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'client_id': serializer.toJson<String>(clientId),
      'invoice_id': serializer.toJson<String>(invoiceId),
    };
  }

  ClientInvoiceData copyWith({String? clientId, String? invoiceId}) =>
      ClientInvoiceData(
        clientId: clientId ?? this.clientId,
        invoiceId: invoiceId ?? this.invoiceId,
      );
  ClientInvoiceData copyWithCompanion(ClientInvoiceCompanion data) {
    return ClientInvoiceData(
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClientInvoiceData(')
          ..write('clientId: $clientId, ')
          ..write('invoiceId: $invoiceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(clientId, invoiceId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClientInvoiceData &&
          other.clientId == this.clientId &&
          other.invoiceId == this.invoiceId);
}

class ClientInvoiceCompanion extends UpdateCompanion<ClientInvoiceData> {
  final Value<String> clientId;
  final Value<String> invoiceId;
  final Value<int> rowid;
  const ClientInvoiceCompanion({
    this.clientId = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClientInvoiceCompanion.insert({
    required String clientId,
    required String invoiceId,
    this.rowid = const Value.absent(),
  })  : clientId = Value(clientId),
        invoiceId = Value(invoiceId);
  static Insertable<ClientInvoiceData> custom({
    Expression<String>? clientId,
    Expression<String>? invoiceId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (clientId != null) 'client_id': clientId,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClientInvoiceCompanion copyWith(
      {Value<String>? clientId, Value<String>? invoiceId, Value<int>? rowid}) {
    return ClientInvoiceCompanion(
      clientId: clientId ?? this.clientId,
      invoiceId: invoiceId ?? this.invoiceId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<String>(invoiceId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientInvoiceCompanion(')
          ..write('clientId: $clientId, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$ShelfDatabase extends GeneratedDatabase {
  _$ShelfDatabase(QueryExecutor e) : super(e);
  $ShelfDatabaseManager get managers => $ShelfDatabaseManager(this);
  late final Product product = Product(this);
  late final Client client = Client(this);
  late final Invoice invoice = Invoice(this);
  late final ProductInvoice productInvoice = ProductInvoice(this);
  late final ClientInvoice clientInvoice = ClientInvoice(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [product, client, invoice, productInvoice, clientInvoice];
}

typedef $ProductCreateCompanionBuilder = ProductCompanion Function({
  required String id,
  required String name,
  required int value,
  required int stock,
  Value<String?> code,
  Value<int> rowid,
});
typedef $ProductUpdateCompanionBuilder = ProductCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<int> value,
  Value<int> stock,
  Value<String?> code,
  Value<int> rowid,
});

class $ProductFilterComposer extends Composer<_$ShelfDatabase, Product> {
  $ProductFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get stock => $composableBuilder(
      column: $table.stock, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));
}

class $ProductOrderingComposer extends Composer<_$ShelfDatabase, Product> {
  $ProductOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get stock => $composableBuilder(
      column: $table.stock, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));
}

class $ProductAnnotationComposer extends Composer<_$ShelfDatabase, Product> {
  $ProductAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<int> get stock =>
      $composableBuilder(column: $table.stock, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);
}

class $ProductTableManager extends RootTableManager<
    _$ShelfDatabase,
    Product,
    ProductData,
    $ProductFilterComposer,
    $ProductOrderingComposer,
    $ProductAnnotationComposer,
    $ProductCreateCompanionBuilder,
    $ProductUpdateCompanionBuilder,
    (ProductData, BaseReferences<_$ShelfDatabase, Product, ProductData>),
    ProductData,
    PrefetchHooks Function()> {
  $ProductTableManager(_$ShelfDatabase db, Product table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $ProductFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $ProductOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $ProductAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> value = const Value.absent(),
            Value<int> stock = const Value.absent(),
            Value<String?> code = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductCompanion(
            id: id,
            name: name,
            value: value,
            stock: stock,
            code: code,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required int value,
            required int stock,
            Value<String?> code = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductCompanion.insert(
            id: id,
            name: name,
            value: value,
            stock: stock,
            code: code,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $ProductProcessedTableManager = ProcessedTableManager<
    _$ShelfDatabase,
    Product,
    ProductData,
    $ProductFilterComposer,
    $ProductOrderingComposer,
    $ProductAnnotationComposer,
    $ProductCreateCompanionBuilder,
    $ProductUpdateCompanionBuilder,
    (ProductData, BaseReferences<_$ShelfDatabase, Product, ProductData>),
    ProductData,
    PrefetchHooks Function()>;
typedef $ClientCreateCompanionBuilder = ClientCompanion Function({
  required String id,
  required String name,
  required String document,
  Value<int> rowid,
});
typedef $ClientUpdateCompanionBuilder = ClientCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> document,
  Value<int> rowid,
});

class $ClientFilterComposer extends Composer<_$ShelfDatabase, Client> {
  $ClientFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get document => $composableBuilder(
      column: $table.document, builder: (column) => ColumnFilters(column));
}

class $ClientOrderingComposer extends Composer<_$ShelfDatabase, Client> {
  $ClientOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get document => $composableBuilder(
      column: $table.document, builder: (column) => ColumnOrderings(column));
}

class $ClientAnnotationComposer extends Composer<_$ShelfDatabase, Client> {
  $ClientAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get document =>
      $composableBuilder(column: $table.document, builder: (column) => column);
}

class $ClientTableManager extends RootTableManager<
    _$ShelfDatabase,
    Client,
    ClientData,
    $ClientFilterComposer,
    $ClientOrderingComposer,
    $ClientAnnotationComposer,
    $ClientCreateCompanionBuilder,
    $ClientUpdateCompanionBuilder,
    (ClientData, BaseReferences<_$ShelfDatabase, Client, ClientData>),
    ClientData,
    PrefetchHooks Function()> {
  $ClientTableManager(_$ShelfDatabase db, Client table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $ClientFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $ClientOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $ClientAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> document = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ClientCompanion(
            id: id,
            name: name,
            document: document,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String document,
            Value<int> rowid = const Value.absent(),
          }) =>
              ClientCompanion.insert(
            id: id,
            name: name,
            document: document,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $ClientProcessedTableManager = ProcessedTableManager<
    _$ShelfDatabase,
    Client,
    ClientData,
    $ClientFilterComposer,
    $ClientOrderingComposer,
    $ClientAnnotationComposer,
    $ClientCreateCompanionBuilder,
    $ClientUpdateCompanionBuilder,
    (ClientData, BaseReferences<_$ShelfDatabase, Client, ClientData>),
    ClientData,
    PrefetchHooks Function()>;
typedef $InvoiceCreateCompanionBuilder = InvoiceCompanion Function({
  required String id,
  required int number,
  required String date,
  Value<int> rowid,
});
typedef $InvoiceUpdateCompanionBuilder = InvoiceCompanion Function({
  Value<String> id,
  Value<int> number,
  Value<String> date,
  Value<int> rowid,
});

class $InvoiceFilterComposer extends Composer<_$ShelfDatabase, Invoice> {
  $InvoiceFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get number => $composableBuilder(
      column: $table.number, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));
}

class $InvoiceOrderingComposer extends Composer<_$ShelfDatabase, Invoice> {
  $InvoiceOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get number => $composableBuilder(
      column: $table.number, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));
}

class $InvoiceAnnotationComposer extends Composer<_$ShelfDatabase, Invoice> {
  $InvoiceAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);
}

class $InvoiceTableManager extends RootTableManager<
    _$ShelfDatabase,
    Invoice,
    InvoiceData,
    $InvoiceFilterComposer,
    $InvoiceOrderingComposer,
    $InvoiceAnnotationComposer,
    $InvoiceCreateCompanionBuilder,
    $InvoiceUpdateCompanionBuilder,
    (InvoiceData, BaseReferences<_$ShelfDatabase, Invoice, InvoiceData>),
    InvoiceData,
    PrefetchHooks Function()> {
  $InvoiceTableManager(_$ShelfDatabase db, Invoice table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $InvoiceFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $InvoiceOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $InvoiceAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<int> number = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              InvoiceCompanion(
            id: id,
            number: number,
            date: date,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required int number,
            required String date,
            Value<int> rowid = const Value.absent(),
          }) =>
              InvoiceCompanion.insert(
            id: id,
            number: number,
            date: date,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $InvoiceProcessedTableManager = ProcessedTableManager<
    _$ShelfDatabase,
    Invoice,
    InvoiceData,
    $InvoiceFilterComposer,
    $InvoiceOrderingComposer,
    $InvoiceAnnotationComposer,
    $InvoiceCreateCompanionBuilder,
    $InvoiceUpdateCompanionBuilder,
    (InvoiceData, BaseReferences<_$ShelfDatabase, Invoice, InvoiceData>),
    InvoiceData,
    PrefetchHooks Function()>;
typedef $ProductInvoiceCreateCompanionBuilder = ProductInvoiceCompanion
    Function({
  required String productId,
  required String invoiceId,
  required int value,
  required int count,
  Value<int> rowid,
});
typedef $ProductInvoiceUpdateCompanionBuilder = ProductInvoiceCompanion
    Function({
  Value<String> productId,
  Value<String> invoiceId,
  Value<int> value,
  Value<int> count,
  Value<int> rowid,
});

class $ProductInvoiceFilterComposer
    extends Composer<_$ShelfDatabase, ProductInvoice> {
  $ProductInvoiceFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get invoiceId => $composableBuilder(
      column: $table.invoiceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get count => $composableBuilder(
      column: $table.count, builder: (column) => ColumnFilters(column));
}

class $ProductInvoiceOrderingComposer
    extends Composer<_$ShelfDatabase, ProductInvoice> {
  $ProductInvoiceOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get productId => $composableBuilder(
      column: $table.productId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get invoiceId => $composableBuilder(
      column: $table.invoiceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get count => $composableBuilder(
      column: $table.count, builder: (column) => ColumnOrderings(column));
}

class $ProductInvoiceAnnotationComposer
    extends Composer<_$ShelfDatabase, ProductInvoice> {
  $ProductInvoiceAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get invoiceId =>
      $composableBuilder(column: $table.invoiceId, builder: (column) => column);

  GeneratedColumn<int> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<int> get count =>
      $composableBuilder(column: $table.count, builder: (column) => column);
}

class $ProductInvoiceTableManager extends RootTableManager<
    _$ShelfDatabase,
    ProductInvoice,
    ProductInvoiceData,
    $ProductInvoiceFilterComposer,
    $ProductInvoiceOrderingComposer,
    $ProductInvoiceAnnotationComposer,
    $ProductInvoiceCreateCompanionBuilder,
    $ProductInvoiceUpdateCompanionBuilder,
    (
      ProductInvoiceData,
      BaseReferences<_$ShelfDatabase, ProductInvoice, ProductInvoiceData>
    ),
    ProductInvoiceData,
    PrefetchHooks Function()> {
  $ProductInvoiceTableManager(_$ShelfDatabase db, ProductInvoice table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $ProductInvoiceFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $ProductInvoiceOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $ProductInvoiceAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> productId = const Value.absent(),
            Value<String> invoiceId = const Value.absent(),
            Value<int> value = const Value.absent(),
            Value<int> count = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductInvoiceCompanion(
            productId: productId,
            invoiceId: invoiceId,
            value: value,
            count: count,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String productId,
            required String invoiceId,
            required int value,
            required int count,
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductInvoiceCompanion.insert(
            productId: productId,
            invoiceId: invoiceId,
            value: value,
            count: count,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $ProductInvoiceProcessedTableManager = ProcessedTableManager<
    _$ShelfDatabase,
    ProductInvoice,
    ProductInvoiceData,
    $ProductInvoiceFilterComposer,
    $ProductInvoiceOrderingComposer,
    $ProductInvoiceAnnotationComposer,
    $ProductInvoiceCreateCompanionBuilder,
    $ProductInvoiceUpdateCompanionBuilder,
    (
      ProductInvoiceData,
      BaseReferences<_$ShelfDatabase, ProductInvoice, ProductInvoiceData>
    ),
    ProductInvoiceData,
    PrefetchHooks Function()>;
typedef $ClientInvoiceCreateCompanionBuilder = ClientInvoiceCompanion Function({
  required String clientId,
  required String invoiceId,
  Value<int> rowid,
});
typedef $ClientInvoiceUpdateCompanionBuilder = ClientInvoiceCompanion Function({
  Value<String> clientId,
  Value<String> invoiceId,
  Value<int> rowid,
});

class $ClientInvoiceFilterComposer
    extends Composer<_$ShelfDatabase, ClientInvoice> {
  $ClientInvoiceFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get clientId => $composableBuilder(
      column: $table.clientId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get invoiceId => $composableBuilder(
      column: $table.invoiceId, builder: (column) => ColumnFilters(column));
}

class $ClientInvoiceOrderingComposer
    extends Composer<_$ShelfDatabase, ClientInvoice> {
  $ClientInvoiceOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get clientId => $composableBuilder(
      column: $table.clientId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get invoiceId => $composableBuilder(
      column: $table.invoiceId, builder: (column) => ColumnOrderings(column));
}

class $ClientInvoiceAnnotationComposer
    extends Composer<_$ShelfDatabase, ClientInvoice> {
  $ClientInvoiceAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get clientId =>
      $composableBuilder(column: $table.clientId, builder: (column) => column);

  GeneratedColumn<String> get invoiceId =>
      $composableBuilder(column: $table.invoiceId, builder: (column) => column);
}

class $ClientInvoiceTableManager extends RootTableManager<
    _$ShelfDatabase,
    ClientInvoice,
    ClientInvoiceData,
    $ClientInvoiceFilterComposer,
    $ClientInvoiceOrderingComposer,
    $ClientInvoiceAnnotationComposer,
    $ClientInvoiceCreateCompanionBuilder,
    $ClientInvoiceUpdateCompanionBuilder,
    (
      ClientInvoiceData,
      BaseReferences<_$ShelfDatabase, ClientInvoice, ClientInvoiceData>
    ),
    ClientInvoiceData,
    PrefetchHooks Function()> {
  $ClientInvoiceTableManager(_$ShelfDatabase db, ClientInvoice table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $ClientInvoiceFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $ClientInvoiceOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $ClientInvoiceAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> clientId = const Value.absent(),
            Value<String> invoiceId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ClientInvoiceCompanion(
            clientId: clientId,
            invoiceId: invoiceId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String clientId,
            required String invoiceId,
            Value<int> rowid = const Value.absent(),
          }) =>
              ClientInvoiceCompanion.insert(
            clientId: clientId,
            invoiceId: invoiceId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $ClientInvoiceProcessedTableManager = ProcessedTableManager<
    _$ShelfDatabase,
    ClientInvoice,
    ClientInvoiceData,
    $ClientInvoiceFilterComposer,
    $ClientInvoiceOrderingComposer,
    $ClientInvoiceAnnotationComposer,
    $ClientInvoiceCreateCompanionBuilder,
    $ClientInvoiceUpdateCompanionBuilder,
    (
      ClientInvoiceData,
      BaseReferences<_$ShelfDatabase, ClientInvoice, ClientInvoiceData>
    ),
    ClientInvoiceData,
    PrefetchHooks Function()>;

class $ShelfDatabaseManager {
  final _$ShelfDatabase _db;
  $ShelfDatabaseManager(this._db);
  $ProductTableManager get product => $ProductTableManager(_db, _db.product);
  $ClientTableManager get client => $ClientTableManager(_db, _db.client);
  $InvoiceTableManager get invoice => $InvoiceTableManager(_db, _db.invoice);
  $ProductInvoiceTableManager get productInvoice =>
      $ProductInvoiceTableManager(_db, _db.productInvoice);
  $ClientInvoiceTableManager get clientInvoice =>
      $ClientInvoiceTableManager(_db, _db.clientInvoice);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$databaseHash() => r'44d1e3f2fcf3dc92cde9a51d3f7f4b0146cfacfd';

/// See also [database].
@ProviderFor(database)
final databaseProvider = AutoDisposeProvider<ShelfDatabase>.internal(
  database,
  name: r'databaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$databaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DatabaseRef = AutoDisposeProviderRef<ShelfDatabase>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
