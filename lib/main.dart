import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/helpers/custom_navigation_helper.dart';
import 'package:project_shelf/state/app.dart';

void main() {
  // Initialize the navigation helper.
  CustomNavigationHelper.instance;

  runApp(
    ProviderScope(
      child: RestorationScope(
        restorationId: 'root',
        child: ShelfApp(),
      ),
    ),
  );
}

class ShelfApp extends StatefulWidget {
  const ShelfApp({super.key});

  @override
  State<StatefulWidget> createState() => _ShelfAppState();
}

class _ShelfAppState extends State<ShelfApp> with RestorationMixin {
  final _RestorableAppState _appState = _RestorableAppState();

  @override
  String? get restorationId => 'wrapper';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_appState, 'state');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      restorationScopeId: 'app',
      title: 'Project Shelf',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: CustomNavigationHelper.router,
    );
  }
}

class _RestorableAppState extends RestorableListenable<AppState> {
  @override
  AppState createDefaultValue() {
    return AppState();
  }

  @override
  AppState fromPrimitives(Object? data) {
    return AppState();
  }

  @override
  Object? toPrimitives() {
    return value;
  }
}
