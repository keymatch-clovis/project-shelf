import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_shelf/feature/backup/presentation/backup_view.dart';
import 'package:project_shelf/feature/configuration/presentation/configuration_view.dart';
// import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/main_wrapper.dart';
// import 'package:project_shelf/views/customer_view.dart';
// import 'package:project_shelf/views/customers_view.dart';
// import 'package:project_shelf/views/create_customer_view.dart';
// import 'package:project_shelf/views/data_load_view.dart';
// import 'package:project_shelf/views/edit_customer_view.dart';
// import 'package:project_shelf/views/invoice_view.dart';
// import 'package:project_shelf/views/invoices_view.dart';
// import 'package:project_shelf/views/create_invoice_view.dart';
// import 'package:project_shelf/views/create_product_view.dart';
// import 'package:project_shelf/views/preferences_view.dart';
// import 'package:project_shelf/views/product_view.dart';
import 'package:project_shelf/views/products_view.dart';

class AppNavigation {
  // Set the default constructor to private.
  AppNavigation._();

  static String initialLocation = '/products';

  /// Private navigator keys
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _productsNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'products-shell');
  static final _invoicesNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'invoices-shell');
  static final _customersNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'customers-shell');
  static final _settingsNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'settings-shell');

  /// Go Router Configuration
  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: initialLocation,
    navigatorKey: _rootNavigatorKey,
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => MainWrapper(
          navigationShell: navigationShell,
        ),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            navigatorKey: _productsNavigatorKey,
            routes: [
              GoRoute(
                path: '/products',
                builder: (context, state) => ProductsView(key: state.pageKey),
                routes: [
                  // GoRoute(
                  //   path: 'create',
                  //   builder: (context, state) =>
                  //       CreateProductView(key: state.pageKey),
                  // ),
                  // GoRoute(
                  //   path: 'product',
                  //   builder: (context, state) => ProductView(
                  //     state.extra as ProductData,
                  //     key: state.pageKey,
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
          // StatefulShellBranch(
          //   navigatorKey: _invoicesNavigatorKey,
          //   routes: [
          //     GoRoute(
          //       path: '/invoices',
          //       name: 'Facturas',
          //       builder: (context, state) => InvoicesView(key: state.pageKey),
          //       routes: [
          //         GoRoute(
          //           path: 'create',
          //           builder: (context, state) =>
          //               CreateInvoiceView(key: state.pageKey),
          //         ),
          //         GoRoute(
          //           path: "invoice",
          //           builder: (_, state) => InvoiceView(
          //             state.extra as InvoiceData,
          //             key: state.pageKey,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
          // StatefulShellBranch(
          //   navigatorKey: _customersNavigatorKey,
          //   routes: [
          //     GoRoute(
          //       path: '/customers',
          //       builder: (context, state) => CustomersView(key: state.pageKey),
          //       routes: [
          //         GoRoute(
          //           path: 'create',
          //           builder: (context, state) =>
          //               CreateCustomerView(key: state.pageKey),
          //         ),
          //         GoRoute(
          //           path: 'customer',
          //           builder: (context, state) => CustomerView(
          //             state.extra as CustomerData,
          //             key: state.pageKey,
          //           ),
          //           routes: [
          //             GoRoute(
          //               path: 'edit',
          //               builder: (context, state) => EditCustomerView(
          //                 state.extra as CustomerData,
          //                 key: state.pageKey,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
          StatefulShellBranch(
            navigatorKey: _settingsNavigatorKey,
            routes: [
              GoRoute(
                path: '/configuration',
                builder: (context, state) =>
                    ConfigurationView(key: state.pageKey),
                routes: [
                  GoRoute(
                    path: "backup",
                    builder: (context, state) {
                      return BackupView(key: state.pageKey);
                    },
                  ),
                  // GoRoute(
                  //   path: "data-load",
                  //   builder: (context, state) =>
                  //       DataLoadView(key: state.pageKey),
                  // ),
                  // GoRoute(
                  //   path: "preferences",
                  //   builder: (context, state) =>
                  //       PreferencesView(key: state.pageKey),
                  // ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
