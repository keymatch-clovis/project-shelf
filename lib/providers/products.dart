import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/database/aggregate.dart';
import 'package:project_shelf/database/commit.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/model/product.dart';
import 'package:project_shelf/providers/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products.g.dart';

const CURRENT_PRODUCT_VERSION = 1;

typedef ProductAggregate = ({
  String id,
  Product product,
});

class ProductsState {
  List<ProductAggregate> products;

  ProductsState({this.products = const []});
}

@riverpod
class Products extends _$Products {
  @override
  FutureOr<ProductsState> build() async {
    return ProductsState(products: await _getAll());
  }

  FutureOr<ProductAggregate> create(Product product) async {
    final database = ref.watch(testDatabaseProvider);

    // Create product.
    final result = database.transaction(() async {
      // Create aggregate.
      final aggregate = await database.aggregateDao.create(
        type: AggregateType.PRODUCT,
        version: CURRENT_PRODUCT_VERSION,
      );

      // Create commit.
      await database.commitDao.create(
        type: CommitType.CREATED,
        aggregateUuid: aggregate.uuid,
        data: product.toBytes(),
      );

      return (id: aggregate.uuid, product: product);
    });

    // Update the current state.
    await _update();

    return result;
  }

  Future<void> _update() async {
    state = AsyncValue.data(ProductsState(products: await _getAll()));
  }

  Future<List<ProductAggregate>> _getAll() async {
    final database = ref.watch(testDatabaseProvider);

    // Find the current aggregates.
    final aggregates = await database.aggregateDao.findByType(
      type: AggregateType.PRODUCT,
      version: CURRENT_PRODUCT_VERSION,
    );

    // Get the commits associated to those aggregates and rebuild the products
    // from the events.
    List<ProductAggregate> products = [];
    for (final aggregate in aggregates) {
      final commits = await database.commitDao.findByAggregate(aggregate);
      products.add((id: aggregate.uuid, product: _rebuild(commits)));
    }
    return products;
  }

  Product _rebuild(List<CommitData> commits) {
    Option<Product> product = Option.none();

    for (final commit in commits) {
      product = switch (commit.type) {
        CommitType.CREATED => Option.some(Product.fromBytes(commit.data)),
        CommitType.NAME_UPDATED =>
          product.map((p) => p.copyWith(name: toString(commit))),
        CommitType.VALUE_UPDATED =>
          product.map((p) => p.copyWith(value: toInt(commit))),
        CommitType.STOCK_UPDATED =>
          product.map((p) => p.copyWith(stock: toInt(commit))),
        CommitType.CODE_UPDATED =>
          product.map((p) => p.copyWith(code: toString(commit))),
      };
    }

    if (product.isNone()) {
      throw "Product is missing CREATED commit!";
    }
    return product.unwrap();
  }
}
