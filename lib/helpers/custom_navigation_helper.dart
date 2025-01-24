import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_shelf/screens/home.dart';

class CustomNavigationHelper {
  static final GlobalKey<NavigatorState> parentNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> homeTabNavigatorKey =
      GlobalKey<NavigatorState>();

  static final CustomNavigationHelper _instance =
      CustomNavigationHelper._internal();

  static CustomNavigationHelper get instance => _instance;

  static late final GoRouter router;

  factory CustomNavigationHelper() {
    return _instance;
  }

  CustomNavigationHelper._internal() {
    final routes = [
      GoRoute(
        path: '/home',
        pageBuilder: (context, state) => _getPage(
          child: const Home(),
          state: state,
        ),
      ),
    ];

    router = GoRouter(
      navigatorKey: parentNavigatorKey,
      initialLocation: '/home',
      routes: routes,
    );
  }
}

Page _getPage({
  required Widget child,
  required GoRouterState state,
}) {
  return MaterialPage(key: state.pageKey, child: child);
}
