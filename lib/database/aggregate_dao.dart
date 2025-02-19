import 'package:drift/drift.dart';
import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/database/aggregate.dart';
import 'package:project_shelf/database/database.dart';

part 'aggregate_dao.g.dart';

@DriftAccessor(tables: [Aggregate])
class AggregateDao extends DatabaseAccessor<ShelfDatabase>
    with _$AggregateDaoMixin {
  AggregateDao(super.db);

  Future<AggregateData> create({
    required AggregateType type,
    required int version,
  }) async {
    final rowId = await (into(aggregate).insert(AggregateCompanion.insert(
      type: type,
      version: version,
    )));

    return (select(aggregate)..where((a) => a.rowId.equals(rowId))).getSingle();
  }

  Future<List<AggregateData>> findByType({
    required AggregateType type,
    required int version,
  }) async {
    // Get the latest aggregate from the supplied type.
    // NOTE: Maybe this can help me later.
    // final latestAggregates = selectOnly(aggregate)
    //   ..addColumns([aggregate.uuid])
    //   ..where(aggregate.type.equalsValue(type))
    //   ..orderBy([OrderingTerm.desc(aggregate.version)])
    //   ..limit(1);

    final query = select(aggregate)
      ..where(
        (row) => row.type.equalsValue(type) & row.version.equals(version),
      );

    return await query.get();
  }
}
