// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $AggregateTable extends Aggregate
    with TableInfo<$AggregateTable, AggregateData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AggregateTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => const Uuid().v4());
  @override
  late final GeneratedColumnWithTypeConverter<AggregateType, String> type =
      GeneratedColumn<String>('type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<AggregateType>($AggregateTable.$convertertype);
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
      'version', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [uuid, type, version];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'aggregate';
  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  AggregateData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AggregateData(
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      type: $AggregateTable.$convertertype.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!),
      version: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}version'])!,
    );
  }

  @override
  $AggregateTable createAlias(String alias) {
    return $AggregateTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<AggregateType, String, String> $convertertype =
      const EnumNameConverter<AggregateType>(AggregateType.values);
}

class AggregateData extends DataClass implements Insertable<AggregateData> {
  final String uuid;
  final AggregateType type;
  final int version;
  const AggregateData(
      {required this.uuid, required this.type, required this.version});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    {
      map['type'] =
          Variable<String>($AggregateTable.$convertertype.toSql(type));
    }
    map['version'] = Variable<int>(version);
    return map;
  }

  AggregateCompanion toCompanion(bool nullToAbsent) {
    return AggregateCompanion(
      uuid: Value(uuid),
      type: Value(type),
      version: Value(version),
    );
  }

  factory AggregateData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AggregateData(
      uuid: serializer.fromJson<String>(json['uuid']),
      type: $AggregateTable.$convertertype
          .fromJson(serializer.fromJson<String>(json['type'])),
      version: serializer.fromJson<int>(json['version']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'type': serializer
          .toJson<String>($AggregateTable.$convertertype.toJson(type)),
      'version': serializer.toJson<int>(version),
    };
  }

  AggregateData copyWith({String? uuid, AggregateType? type, int? version}) =>
      AggregateData(
        uuid: uuid ?? this.uuid,
        type: type ?? this.type,
        version: version ?? this.version,
      );
  AggregateData copyWithCompanion(AggregateCompanion data) {
    return AggregateData(
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      type: data.type.present ? data.type.value : this.type,
      version: data.version.present ? data.version.value : this.version,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AggregateData(')
          ..write('uuid: $uuid, ')
          ..write('type: $type, ')
          ..write('version: $version')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(uuid, type, version);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AggregateData &&
          other.uuid == this.uuid &&
          other.type == this.type &&
          other.version == this.version);
}

class AggregateCompanion extends UpdateCompanion<AggregateData> {
  final Value<String> uuid;
  final Value<AggregateType> type;
  final Value<int> version;
  final Value<int> rowid;
  const AggregateCompanion({
    this.uuid = const Value.absent(),
    this.type = const Value.absent(),
    this.version = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AggregateCompanion.insert({
    this.uuid = const Value.absent(),
    required AggregateType type,
    required int version,
    this.rowid = const Value.absent(),
  })  : type = Value(type),
        version = Value(version);
  static Insertable<AggregateData> custom({
    Expression<String>? uuid,
    Expression<String>? type,
    Expression<int>? version,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (type != null) 'type': type,
      if (version != null) 'version': version,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AggregateCompanion copyWith(
      {Value<String>? uuid,
      Value<AggregateType>? type,
      Value<int>? version,
      Value<int>? rowid}) {
    return AggregateCompanion(
      uuid: uuid ?? this.uuid,
      type: type ?? this.type,
      version: version ?? this.version,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (type.present) {
      map['type'] =
          Variable<String>($AggregateTable.$convertertype.toSql(type.value));
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AggregateCompanion(')
          ..write('uuid: $uuid, ')
          ..write('type: $type, ')
          ..write('version: $version, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CommitTable extends Commit with TableInfo<$CommitTable, CommitData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CommitTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => const Uuid().v1());
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDate);
  @override
  late final GeneratedColumnWithTypeConverter<CommitType, String> type =
      GeneratedColumn<String>('type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<CommitType>($CommitTable.$convertertype);
  @override
  late final GeneratedColumn<Uint8List> data = GeneratedColumn<Uint8List>(
      'data', aliasedName, false,
      type: DriftSqlType.blob, requiredDuringInsert: true);
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
      'version', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  late final GeneratedColumn<String> aggregate = GeneratedColumn<String>(
      'aggregate', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES aggregate (uuid)'));
  @override
  List<GeneratedColumn> get $columns =>
      [uuid, date, type, data, version, aggregate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'commit';
  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  CommitData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CommitData(
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      type: $CommitTable.$convertertype.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!),
      data: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}data'])!,
      version: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}version'])!,
      aggregate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}aggregate'])!,
    );
  }

  @override
  $CommitTable createAlias(String alias) {
    return $CommitTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CommitType, String, String> $convertertype =
      const EnumNameConverter<CommitType>(CommitType.values);
}

class CommitData extends DataClass implements Insertable<CommitData> {
  final String uuid;
  final DateTime date;
  final CommitType type;
  final Uint8List data;
  final int version;
  final String aggregate;
  const CommitData(
      {required this.uuid,
      required this.date,
      required this.type,
      required this.data,
      required this.version,
      required this.aggregate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    map['date'] = Variable<DateTime>(date);
    {
      map['type'] = Variable<String>($CommitTable.$convertertype.toSql(type));
    }
    map['data'] = Variable<Uint8List>(data);
    map['version'] = Variable<int>(version);
    map['aggregate'] = Variable<String>(aggregate);
    return map;
  }

  CommitCompanion toCompanion(bool nullToAbsent) {
    return CommitCompanion(
      uuid: Value(uuid),
      date: Value(date),
      type: Value(type),
      data: Value(data),
      version: Value(version),
      aggregate: Value(aggregate),
    );
  }

  factory CommitData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CommitData(
      uuid: serializer.fromJson<String>(json['uuid']),
      date: serializer.fromJson<DateTime>(json['date']),
      type: $CommitTable.$convertertype
          .fromJson(serializer.fromJson<String>(json['type'])),
      data: serializer.fromJson<Uint8List>(json['data']),
      version: serializer.fromJson<int>(json['version']),
      aggregate: serializer.fromJson<String>(json['aggregate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'date': serializer.toJson<DateTime>(date),
      'type':
          serializer.toJson<String>($CommitTable.$convertertype.toJson(type)),
      'data': serializer.toJson<Uint8List>(data),
      'version': serializer.toJson<int>(version),
      'aggregate': serializer.toJson<String>(aggregate),
    };
  }

  CommitData copyWith(
          {String? uuid,
          DateTime? date,
          CommitType? type,
          Uint8List? data,
          int? version,
          String? aggregate}) =>
      CommitData(
        uuid: uuid ?? this.uuid,
        date: date ?? this.date,
        type: type ?? this.type,
        data: data ?? this.data,
        version: version ?? this.version,
        aggregate: aggregate ?? this.aggregate,
      );
  CommitData copyWithCompanion(CommitCompanion data) {
    return CommitData(
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      date: data.date.present ? data.date.value : this.date,
      type: data.type.present ? data.type.value : this.type,
      data: data.data.present ? data.data.value : this.data,
      version: data.version.present ? data.version.value : this.version,
      aggregate: data.aggregate.present ? data.aggregate.value : this.aggregate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CommitData(')
          ..write('uuid: $uuid, ')
          ..write('date: $date, ')
          ..write('type: $type, ')
          ..write('data: $data, ')
          ..write('version: $version, ')
          ..write('aggregate: $aggregate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      uuid, date, type, $driftBlobEquality.hash(data), version, aggregate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommitData &&
          other.uuid == this.uuid &&
          other.date == this.date &&
          other.type == this.type &&
          $driftBlobEquality.equals(other.data, this.data) &&
          other.version == this.version &&
          other.aggregate == this.aggregate);
}

class CommitCompanion extends UpdateCompanion<CommitData> {
  final Value<String> uuid;
  final Value<DateTime> date;
  final Value<CommitType> type;
  final Value<Uint8List> data;
  final Value<int> version;
  final Value<String> aggregate;
  final Value<int> rowid;
  const CommitCompanion({
    this.uuid = const Value.absent(),
    this.date = const Value.absent(),
    this.type = const Value.absent(),
    this.data = const Value.absent(),
    this.version = const Value.absent(),
    this.aggregate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CommitCompanion.insert({
    this.uuid = const Value.absent(),
    this.date = const Value.absent(),
    required CommitType type,
    required Uint8List data,
    required int version,
    required String aggregate,
    this.rowid = const Value.absent(),
  })  : type = Value(type),
        data = Value(data),
        version = Value(version),
        aggregate = Value(aggregate);
  static Insertable<CommitData> custom({
    Expression<String>? uuid,
    Expression<DateTime>? date,
    Expression<String>? type,
    Expression<Uint8List>? data,
    Expression<int>? version,
    Expression<String>? aggregate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (date != null) 'date': date,
      if (type != null) 'type': type,
      if (data != null) 'data': data,
      if (version != null) 'version': version,
      if (aggregate != null) 'aggregate': aggregate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CommitCompanion copyWith(
      {Value<String>? uuid,
      Value<DateTime>? date,
      Value<CommitType>? type,
      Value<Uint8List>? data,
      Value<int>? version,
      Value<String>? aggregate,
      Value<int>? rowid}) {
    return CommitCompanion(
      uuid: uuid ?? this.uuid,
      date: date ?? this.date,
      type: type ?? this.type,
      data: data ?? this.data,
      version: version ?? this.version,
      aggregate: aggregate ?? this.aggregate,
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
    if (type.present) {
      map['type'] =
          Variable<String>($CommitTable.$convertertype.toSql(type.value));
    }
    if (data.present) {
      map['data'] = Variable<Uint8List>(data.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (aggregate.present) {
      map['aggregate'] = Variable<String>(aggregate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommitCompanion(')
          ..write('uuid: $uuid, ')
          ..write('date: $date, ')
          ..write('type: $type, ')
          ..write('data: $data, ')
          ..write('version: $version, ')
          ..write('aggregate: $aggregate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$ShelfDatabase extends GeneratedDatabase {
  _$ShelfDatabase(QueryExecutor e) : super(e);
  $ShelfDatabaseManager get managers => $ShelfDatabaseManager(this);
  late final $AggregateTable aggregate = $AggregateTable(this);
  late final $CommitTable commit = $CommitTable(this);
  late final CommitDao commitDao = CommitDao(this as ShelfDatabase);
  late final AggregateDao aggregateDao = AggregateDao(this as ShelfDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [aggregate, commit];
}

typedef $$AggregateTableCreateCompanionBuilder = AggregateCompanion Function({
  Value<String> uuid,
  required AggregateType type,
  required int version,
  Value<int> rowid,
});
typedef $$AggregateTableUpdateCompanionBuilder = AggregateCompanion Function({
  Value<String> uuid,
  Value<AggregateType> type,
  Value<int> version,
  Value<int> rowid,
});

final class $$AggregateTableReferences
    extends BaseReferences<_$ShelfDatabase, $AggregateTable, AggregateData> {
  $$AggregateTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CommitTable, List<CommitData>> _commitRefsTable(
          _$ShelfDatabase db) =>
      MultiTypedResultKey.fromTable(db.commit,
          aliasName:
              $_aliasNameGenerator(db.aggregate.uuid, db.commit.aggregate));

  $$CommitTableProcessedTableManager get commitRefs {
    final manager = $$CommitTableTableManager($_db, $_db.commit)
        .filter((f) => f.aggregate.uuid($_item.uuid));

    final cache = $_typedResult.readTableOrNull(_commitRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$AggregateTableFilterComposer
    extends Composer<_$ShelfDatabase, $AggregateTable> {
  $$AggregateTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<AggregateType, AggregateType, String>
      get type => $composableBuilder(
          column: $table.type,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnFilters(column));

  Expression<bool> commitRefs(
      Expression<bool> Function($$CommitTableFilterComposer f) f) {
    final $$CommitTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uuid,
        referencedTable: $db.commit,
        getReferencedColumn: (t) => t.aggregate,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CommitTableFilterComposer(
              $db: $db,
              $table: $db.commit,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AggregateTableOrderingComposer
    extends Composer<_$ShelfDatabase, $AggregateTable> {
  $$AggregateTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uuid => $composableBuilder(
      column: $table.uuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnOrderings(column));
}

class $$AggregateTableAnnotationComposer
    extends Composer<_$ShelfDatabase, $AggregateTable> {
  $$AggregateTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumnWithTypeConverter<AggregateType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  Expression<T> commitRefs<T extends Object>(
      Expression<T> Function($$CommitTableAnnotationComposer a) f) {
    final $$CommitTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uuid,
        referencedTable: $db.commit,
        getReferencedColumn: (t) => t.aggregate,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CommitTableAnnotationComposer(
              $db: $db,
              $table: $db.commit,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AggregateTableTableManager extends RootTableManager<
    _$ShelfDatabase,
    $AggregateTable,
    AggregateData,
    $$AggregateTableFilterComposer,
    $$AggregateTableOrderingComposer,
    $$AggregateTableAnnotationComposer,
    $$AggregateTableCreateCompanionBuilder,
    $$AggregateTableUpdateCompanionBuilder,
    (AggregateData, $$AggregateTableReferences),
    AggregateData,
    PrefetchHooks Function({bool commitRefs})> {
  $$AggregateTableTableManager(_$ShelfDatabase db, $AggregateTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AggregateTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AggregateTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AggregateTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> uuid = const Value.absent(),
            Value<AggregateType> type = const Value.absent(),
            Value<int> version = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AggregateCompanion(
            uuid: uuid,
            type: type,
            version: version,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> uuid = const Value.absent(),
            required AggregateType type,
            required int version,
            Value<int> rowid = const Value.absent(),
          }) =>
              AggregateCompanion.insert(
            uuid: uuid,
            type: type,
            version: version,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AggregateTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({commitRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (commitRefs) db.commit],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (commitRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$AggregateTableReferences._commitRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AggregateTableReferences(db, table, p0)
                                .commitRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.aggregate == item.uuid),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$AggregateTableProcessedTableManager = ProcessedTableManager<
    _$ShelfDatabase,
    $AggregateTable,
    AggregateData,
    $$AggregateTableFilterComposer,
    $$AggregateTableOrderingComposer,
    $$AggregateTableAnnotationComposer,
    $$AggregateTableCreateCompanionBuilder,
    $$AggregateTableUpdateCompanionBuilder,
    (AggregateData, $$AggregateTableReferences),
    AggregateData,
    PrefetchHooks Function({bool commitRefs})>;
typedef $$CommitTableCreateCompanionBuilder = CommitCompanion Function({
  Value<String> uuid,
  Value<DateTime> date,
  required CommitType type,
  required Uint8List data,
  required int version,
  required String aggregate,
  Value<int> rowid,
});
typedef $$CommitTableUpdateCompanionBuilder = CommitCompanion Function({
  Value<String> uuid,
  Value<DateTime> date,
  Value<CommitType> type,
  Value<Uint8List> data,
  Value<int> version,
  Value<String> aggregate,
  Value<int> rowid,
});

final class $$CommitTableReferences
    extends BaseReferences<_$ShelfDatabase, $CommitTable, CommitData> {
  $$CommitTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AggregateTable _aggregateTable(_$ShelfDatabase db) =>
      db.aggregate.createAlias(
          $_aliasNameGenerator(db.commit.aggregate, db.aggregate.uuid));

  $$AggregateTableProcessedTableManager get aggregate {
    final manager = $$AggregateTableTableManager($_db, $_db.aggregate)
        .filter((f) => f.uuid($_item.aggregate));
    final item = $_typedResult.readTableOrNull(_aggregateTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CommitTableFilterComposer
    extends Composer<_$ShelfDatabase, $CommitTable> {
  $$CommitTableFilterComposer({
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

  ColumnWithTypeConverterFilters<CommitType, CommitType, String> get type =>
      $composableBuilder(
          column: $table.type,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<Uint8List> get data => $composableBuilder(
      column: $table.data, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnFilters(column));

  $$AggregateTableFilterComposer get aggregate {
    final $$AggregateTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.aggregate,
        referencedTable: $db.aggregate,
        getReferencedColumn: (t) => t.uuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AggregateTableFilterComposer(
              $db: $db,
              $table: $db.aggregate,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CommitTableOrderingComposer
    extends Composer<_$ShelfDatabase, $CommitTable> {
  $$CommitTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<Uint8List> get data => $composableBuilder(
      column: $table.data, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnOrderings(column));

  $$AggregateTableOrderingComposer get aggregate {
    final $$AggregateTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.aggregate,
        referencedTable: $db.aggregate,
        getReferencedColumn: (t) => t.uuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AggregateTableOrderingComposer(
              $db: $db,
              $table: $db.aggregate,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CommitTableAnnotationComposer
    extends Composer<_$ShelfDatabase, $CommitTable> {
  $$CommitTableAnnotationComposer({
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

  GeneratedColumnWithTypeConverter<CommitType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<Uint8List> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  $$AggregateTableAnnotationComposer get aggregate {
    final $$AggregateTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.aggregate,
        referencedTable: $db.aggregate,
        getReferencedColumn: (t) => t.uuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AggregateTableAnnotationComposer(
              $db: $db,
              $table: $db.aggregate,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CommitTableTableManager extends RootTableManager<
    _$ShelfDatabase,
    $CommitTable,
    CommitData,
    $$CommitTableFilterComposer,
    $$CommitTableOrderingComposer,
    $$CommitTableAnnotationComposer,
    $$CommitTableCreateCompanionBuilder,
    $$CommitTableUpdateCompanionBuilder,
    (CommitData, $$CommitTableReferences),
    CommitData,
    PrefetchHooks Function({bool aggregate})> {
  $$CommitTableTableManager(_$ShelfDatabase db, $CommitTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CommitTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CommitTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CommitTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> uuid = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<CommitType> type = const Value.absent(),
            Value<Uint8List> data = const Value.absent(),
            Value<int> version = const Value.absent(),
            Value<String> aggregate = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CommitCompanion(
            uuid: uuid,
            date: date,
            type: type,
            data: data,
            version: version,
            aggregate: aggregate,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> uuid = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            required CommitType type,
            required Uint8List data,
            required int version,
            required String aggregate,
            Value<int> rowid = const Value.absent(),
          }) =>
              CommitCompanion.insert(
            uuid: uuid,
            date: date,
            type: type,
            data: data,
            version: version,
            aggregate: aggregate,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$CommitTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({aggregate = false}) {
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
                if (aggregate) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.aggregate,
                    referencedTable:
                        $$CommitTableReferences._aggregateTable(db),
                    referencedColumn:
                        $$CommitTableReferences._aggregateTable(db).uuid,
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

typedef $$CommitTableProcessedTableManager = ProcessedTableManager<
    _$ShelfDatabase,
    $CommitTable,
    CommitData,
    $$CommitTableFilterComposer,
    $$CommitTableOrderingComposer,
    $$CommitTableAnnotationComposer,
    $$CommitTableCreateCompanionBuilder,
    $$CommitTableUpdateCompanionBuilder,
    (CommitData, $$CommitTableReferences),
    CommitData,
    PrefetchHooks Function({bool aggregate})>;

class $ShelfDatabaseManager {
  final _$ShelfDatabase _db;
  $ShelfDatabaseManager(this._db);
  $$AggregateTableTableManager get aggregate =>
      $$AggregateTableTableManager(_db, _db.aggregate);
  $$CommitTableTableManager get commit =>
      $$CommitTableTableManager(_db, _db.commit);
}
