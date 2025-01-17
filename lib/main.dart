import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_shelf/models/product.dart';
import 'package:project_shelf/routes/home/home.dart';
import 'package:project_shelf/routes/home/products/products.dart';
import 'package:project_shelf/state/app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const RestorationScope(restorationId: 'root', child: ShelfApp()));
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

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
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => ProductModel())],
        child: MaterialApp.router(
          restorationScopeId: 'app',
          title: 'Project Shelf',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routerConfig: GoRouter(
            navigatorKey: _rootNavigatorKey,
            restorationScopeId: 'router',
            initialLocation: '/products',
            routes: [
              ShellRoute(
                navigatorKey: _shellNavigatorKey,
                pageBuilder: (context, state, child) {
                  return MaterialPage(
                      restorationId: 'router.shell',
                      child: Home(
                        restorationId: 'home',
                        child: child,
                        onTap: (index) {
                          if (index == 0) {
                            context.go('/products');
                          }
                        },
                      ));
                },
                routes: [
                  GoRoute(
                      path: '/products',
                      pageBuilder: (context, state) {
                        return MaterialPage(
                          restorationId: 'route.products',
                          child: Products(
                            key: state.pageKey,
                            restorationId: 'products',
                          ),
                        );
                      }),
                ],
              ),
            ],
          ),
        ));
  }
}

class _RestorableAppState extends RestorableListenable<AppState> {
  @override
  AppState createDefaultValue() {
    return AppState();
  }

  @override
  AppState fromPrimitives(Object? data) {
    print("primitives app $data");
    return AppState();
  }

  @override
  Object? toPrimitives() {
    return value;
  }
}
