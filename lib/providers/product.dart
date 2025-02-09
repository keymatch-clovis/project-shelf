import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/database/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product.g.dart';

@riverpod
Future<ProductData> product(Ref ref, String id) async {
  return await ref.watch(databaseProvider).getProduct(id);
}
