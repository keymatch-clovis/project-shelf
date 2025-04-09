import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_shelf/main_wrapper.dart';
import 'package:project_shelf/ui/view/product/product_list_view.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _productsNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'products-shell',
);

const INITIAL_LOCATION = '/products';

final routerProvider = Provider.autoDispose((ref) {
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: INITIAL_LOCATION,
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
                builder: (context, state) => ProductListView(
                  key: state.pageKey,
                ),
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
          // StatefulShellBranch(
          //   navigatorKey: _settingsNavigatorKey,
          //   routes: [
          //     // GoRoute(
          //     //   path: '/configuration',
          //     //   builder: (context, state) =>
          //     //       ConfigurationView(key: state.pageKey),
          //     //   routes: [
          //     //     // GoRoute(
          //     //     //   path: "backup",
          //     //     //   builder: (context, state) {
          //     //     //     return BackupView(key: state.pageKey);
          //     //     //   },
          //     //     // ),
          //     //     // GoRoute(
          //     //     //   path: "data-load",
          //     //     //   builder: (context, state) =>
          //     //     //       DataLoadView(key: state.pageKey),
          //     //     // ),
          //     //     // GoRoute(
          //     //     //   path: "preferences",
          //     //     //   builder: (context, state) =>
          //     //     //       PreferencesView(key: state.pageKey),
          //     //     // ),
          //     //   ],
          //     // ),
          //   ],
          // ),
        ],
      ),
    ],
  );
});
