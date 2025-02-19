// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$databaseHash() => r'a5f2c495d3b8e2cb7cd1d54a3b36e149c5d951cf';

/// See also [Database].
@ProviderFor(Database)
final databaseProvider =
    AutoDisposeNotifierProvider<Database, ShelfDatabase>.internal(
  Database.new,
  name: r'databaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$databaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Database = AutoDisposeNotifier<ShelfDatabase>;
String _$testDatabaseHash() => r'd91eadf7dab03d98bb4e7cdd738a9284ca29ad36';

/// See also [TestDatabase].
@ProviderFor(TestDatabase)
final testDatabaseProvider =
    AutoDisposeNotifierProvider<TestDatabase, ShelfDatabase>.internal(
  TestDatabase.new,
  name: r'testDatabaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$testDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TestDatabase = AutoDisposeNotifier<ShelfDatabase>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
