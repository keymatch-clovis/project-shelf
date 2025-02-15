import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_shelf/main_wrapper.dart';
import 'package:project_shelf/views/client_view.dart';
import 'package:project_shelf/views/clients_view.dart';
import 'package:project_shelf/views/create_client_view.dart';
import 'package:project_shelf/views/invoices_view.dart';
import 'package:project_shelf/views/create_invoice_view.dart';
import 'package:project_shelf/views/create_product_view.dart';
import 'package:project_shelf/views/product_view.dart';
import 'package:project_shelf/views/products_view.dart';
import 'package:project_shelf/views/settings_view.dart';

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
  static final _clientsNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'clients-shell');
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
          StatefulShellBranch(
            navigatorKey: _clientsNavigatorKey,
            routes: [
              GoRoute(
                path: '/clients',
                builder: (context, state) => ClientsView(key: state.pageKey),
                routes: [
                  GoRoute(
                    path: 'create',
                    builder: (context, state) =>
                        CreateClientView(key: state.pageKey),
                  ),
                  GoRoute(
                    path: 'client/:id',
                    builder: (context, state) => ClientView(
                      key: state.pageKey,
                      id: state.pathParameters['id']!,
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _settingsNavigatorKey,
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => SettingsView(key: state.pageKey),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
