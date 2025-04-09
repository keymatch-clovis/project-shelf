import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:project_shelf/router_provider.dart';
import 'package:project_shelf/shared/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  debugPaintSizeEnabled = false;
  await Jiffy.setLocale('es');

  // > Think of Main as the dirtiest of all the dirty components.
  // > -- Clean Architecture

  runApp(
    ProviderScope(
      child: ShelfApp(),
    ),
  );
}

class ShelfApp extends ConsumerWidget {
  const ShelfApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      restorationScopeId: 'app',
      title: 'Project Shelf',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: GREEN_600,
        ),
        scaffoldBackgroundColor: STONE_100,
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
