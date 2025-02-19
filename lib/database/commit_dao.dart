import 'package:drift/drift.dart';
import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/database/commit.dart';
import 'package:project_shelf/database/database.dart';

part 'commit_dao.g.dart';

@DriftAccessor(tables: [Commit])
class CommitDao extends DatabaseAccessor<ShelfDatabase> with _$CommitDaoMixin {
  CommitDao(super.db);

  Future<CommitData> create({
    required CommitType type,
    required String aggregateUuid,
    required Uint8List data,
  }) async {
    final latestCommit = Option.from(
      await (select(commit)
            ..where((c) => c.type.equalsValue(type))
            ..orderBy([(c) => OrderingTerm.desc(c.version)])
            ..limit(1))
          .getSingleOrNull(),
    );

    final rowId = await (into(commit).insert(CommitCompanion.insert(
      type: type,
      version: latestCommit.map((c) => c.version).unwrapOr(1) + 1,
      aggregate: aggregateUuid,
      data: data,
    )));

    return (select(commit)..where((c) => c.rowId.equals(rowId))).getSingle();
  }

  Future<List<CommitData>> findByAggregate(AggregateData aggregate) {
    return (select(commit)..where((c) => c.aggregate.equals(aggregate.uuid)))
        .get();
  }
}
