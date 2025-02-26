import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/navigation/app_navigation.dart';

void main() {
  runApp(
    ProviderScope(
      child: RestorationScope(
        restorationId: 'main',
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

class _ShelfAppState extends State<ShelfApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      restorationScopeId: 'app',
      title: 'Project Shelf',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: AppNavigation.router,
    );
  }
}
