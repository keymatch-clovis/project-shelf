import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_shelf/adapter/presenter/config_presenter.dart';
import 'package:project_shelf/adapter/presenter/product_presenter.dart';
import 'package:project_shelf/app/use_case/delete_all_products_use_case.dart';
import 'package:project_shelf/app/use_case/find_products_use_case.dart';
import 'package:project_shelf/app/use_case/seed_products_use_case.dart';
import 'package:project_shelf/router_provider.dart';
import 'package:project_shelf/shared/data_access/sqlite_data_access.dart';
import 'package:project_shelf/shared/database/sqlite_product_data_access.dart';

// > Think of Main as the dirtiest of all the dirty components.
// > -- Clean Architecture
// This module will be an initializing module, creating all of the providers
// the app needs.

// Create a provider for the database. We need a provider so we can load the
// database with the app running.
final dataAccessProvider = FutureProvider((ref) async {
  final dataAccess = SqliteDataAccess();

  // Always open the database at application start.
  await dataAccess.openDatabase();

  return dataAccess;
});

/// Data accessors.
final sqliteProductDataAccessProvider = FutureProvider((ref) async {
  return SqliteProductDataAccess(await ref.watch(dataAccessProvider.future));
});

/// Use cases.
final findProductsUseCaseProvider = FutureProvider((ref) async {
  return FindProductsUseCase(
    await ref.watch(sqliteProductDataAccessProvider.future),
  );
});

final seedProductsUseCaseProvider = FutureProvider((ref) async {
  return SeedProductsUseCase(
    await ref.watch(sqliteProductDataAccessProvider.future),
  );
});

final deleteAllProductsUseCaseProvider = FutureProvider((ref) async {
  return DeleteAllProductsUseCase(
    await ref.watch(sqliteProductDataAccessProvider.future),
  );
});

/// Presenters.
final productPresenterProvider = FutureProvider((ref) async {
  return ProductPresenter(
    findProductsUseCase: await ref.watch(findProductsUseCaseProvider.future),
  );
});

final configPresenterProvider = FutureProvider((ref) async {
  return ConfigPresenter(
    seedProductsUseCase: await ref.watch(seedProductsUseCaseProvider.future),
    deleteAllProductsUseCase:
        await ref.watch(deleteAllProductsUseCaseProvider.future),
  );
});

/// View models.
final productListViewModelProvider = FutureProvider((ref) async {
  final presenter = await ref.watch(productPresenterProvider.future);
  final router = ref.watch(routerProvider);

  return presenter.presentProductList(router);
});

final debugLoadDataViewModelProvider = FutureProvider((ref) async {
  final presenter = await ref.watch(configPresenterProvider.future);

  return presenter.presentDebugLoadDataView(
    onProductsChanged: () => ref.invalidate(productListViewModelProvider),
  );
});
