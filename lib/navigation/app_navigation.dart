import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_shelf/main_wrapper.dart';
import 'package:project_shelf/views/create_invoice_view.dart';
import 'package:project_shelf/views/create_product_view.dart';
import 'package:project_shelf/views/invoices_view.dart';
import 'package:project_shelf/views/product_view.dart';
import 'package:project_shelf/views/products_view.dart';

class AppNavigation {
  // Set the default constructor to private.
  AppNavigation._();

  static String initialLocation = '/products';

  /// Private navigator keys
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _homeNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'home-shell');
  static final _invoicesNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'invoices-shell');

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
            navigatorKey: _homeNavigatorKey,
            routes: [
              GoRoute(
                path: '/products',
                builder: (context, state) => ProductsView(key: state.pageKey),
                routes: [
                  GoRoute(
                    path: 'create',
                    builder: (context, state) =>
                        CreateProductView(key: state.pageKey),
                  ),
                  GoRoute(
                    path: 'product/:id',
                    builder: (context, state) => ProductView(
                      key: state.pageKey,
                      id: state.pathParameters['id']!,
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _invoicesNavigatorKey,
            routes: [
              GoRoute(
                path: '/invoices',
                name: 'Facturas',
                builder: (context, state) => InvoicesView(key: state.pageKey),
                routes: [
                  GoRoute(
                    path: 'create',
                    builder: (context, state) =>
                        CreateInvoiceView(key: state.pageKey),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
