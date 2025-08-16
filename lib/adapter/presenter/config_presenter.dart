import 'package:project_shelf/adapter/view_model/debug_load_data_view_model.dart';
import 'package:project_shelf/app/use_case/delete_all_products_use_case.dart';
import 'package:project_shelf/app/use_case/seed_products_use_case.dart';

class ConfigPresenter {
  final SeedProductsUseCase seedProductsUseCase;
  final DeleteAllProductsUseCase deleteAllProductsUseCase;

  ConfigPresenter({
    required this.seedProductsUseCase,
    required this.deleteAllProductsUseCase,
  });

  DebugLoadDataViewModel presentDebugLoadDataView({
    required Function onProductsChanged,
  }) {
    return DebugLoadDataViewModel(
      seedProducts: () async {
        await this.seedProductsUseCase.execute();
        onProductsChanged();
      },
      deleteAllProducts: () async {
        await this.deleteAllProductsUseCase.execute();
        onProductsChanged();
      },
    );
  }
}
