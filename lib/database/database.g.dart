// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class Product extends Table with TableInfo<Product, ProductData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Product(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
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
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
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
  final int id;
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
    map['id'] = Variable<int>(id);
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
      id: serializer.fromJson<int>(json['id']),
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
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'value': serializer.toJson<int>(value),
      'stock': serializer.toJson<int>(stock),
      'code': serializer.toJson<String?>(code),
    };
  }

  ProductData copyWith(
          {int? id,
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
  final Value<int> id;
  final Value<String> name;
  final Value<int> value;
  final Value<int> stock;
  final Value<String?> code;
  const ProductCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.value = const Value.absent(),
    this.stock = const Value.absent(),
    this.code = const Value.absent(),
  });
  ProductCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int value,
    required int stock,
    this.code = const Value.absent(),
  })  : name = Value(name),
        value = Value(value),
        stock = Value(stock);
  static Insertable<ProductData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? value,
    Expression<int>? stock,
    Expression<String>? code,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (value != null) 'value': value,
      if (stock != null) 'stock': stock,
      if (code != null) 'code': code,
    });
  }

  ProductCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<int>? value,
      Value<int>? stock,
      Value<String?>? code}) {
    return ProductCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      value: value ?? this.value,
      stock: stock ?? this.stock,
      code: code ?? this.code,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('value: $value, ')
          ..write('stock: $stock, ')
          ..write('code: $code')
          ..write(')'))
        .toString();
  }
}

abstract class _$ShelfDatabase extends GeneratedDatabase {
  _$ShelfDatabase(QueryExecutor e) : super(e);
  $ShelfDatabaseManager get managers => $ShelfDatabaseManager(this);
  late final Product product = Product(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [product];
}

typedef $ProductCreateCompanionBuilder = ProductCompanion Function({
  Value<int> id,
  required String name,
  required int value,
  required int stock,
  Value<String?> code,
});
typedef $ProductUpdateCompanionBuilder = ProductCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<int> value,
  Value<int> stock,
  Value<String?> code,
});

class $ProductFilterComposer extends Composer<_$ShelfDatabase, Product> {
  $ProductFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
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
  ColumnOrderings<int> get id => $composableBuilder(
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
  GeneratedColumn<int> get id =>
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
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> value = const Value.absent(),
            Value<int> stock = const Value.absent(),
            Value<String?> code = const Value.absent(),
          }) =>
              ProductCompanion(
            id: id,
            name: name,
            value: value,
            stock: stock,
            code: code,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required int value,
            required int stock,
            Value<String?> code = const Value.absent(),
          }) =>
              ProductCompanion.insert(
            id: id,
            name: name,
            value: value,
            stock: stock,
            code: code,
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

class $ShelfDatabaseManager {
  final _$ShelfDatabase _db;
  $ShelfDatabaseManager(this._db);
  $ProductTableManager get product => $ProductTableManager(_db, _db.product);
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
