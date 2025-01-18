import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/models/product.dart';
import 'package:project_shelf/routes/home/home.dart';
import 'package:project_shelf/screens/create_product.dart';
import 'package:project_shelf/screens/products.dart';
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
      providers: [
        Provider<AppDatabase>(
          create: (context) => AppDatabase(),
          dispose: (context, db) => db.close(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductModel(
            Provider.of<AppDatabase>(context, listen: false),
          ),
        ),
      ],
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
                  pageBuilder: (context, state) => MaterialPage(
                    restorationId: 'route.products',
                    child: ProductsScreen(
                      restorationId: 'products',
                      key: state.pageKey,
                    ),
                  ),
                  routes: [
                    GoRoute(
                      parentNavigatorKey: _rootNavigatorKey,
                      path: 'create',
                      pageBuilder: (context, state) => MaterialPage(
                        restorationId: 'route.products.create',
                        child: CreateProductScreen(
                          restorationId: 'products.create',
                          key: state.pageKey,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
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
    print("primitives app $data");
    return AppState();
  }

  @override
  Object? toPrimitives() {
    return value;
  }
}
