import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/shared/presentation/widgets/dialog/loading_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainWrapper extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainWrapper({super.key, required this.navigationShell});

  @override
  MainWrapperState createState() => MainWrapperState();
}

class MainWrapperState extends ConsumerState<MainWrapper> {
  int selectedIndex = 0;
  bool isFirstOpen = true;

  void _goToBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  Future<void> _firstLoad() async {
    final prefs = SharedPreferencesAsync();
    var firstOpen =
        await prefs.getBool("isFirstOpen").then((r) => Option.from(r));

    // If this is the very first time, the shared preference will not be
    // defined, so do that.
    if (firstOpen.isNone()) {
      await prefs.setBool("isFirstOpen", true);
      firstOpen = Option.some(true);
    }

    // Do stuff on first open.
    if (firstOpen.unwrap()) {
      // await ref.watch(citiesRepositoryProvider.notifier).loadLocalData();
      //
      await prefs.setBool("isFirstOpen", false);
      firstOpen = Option.some(false);
    }

    setState(() {
      isFirstOpen = firstOpen.unwrap();
    });
  }

  @override
  void initState() {
    super.initState();
    _firstLoad();
  }

  @override
  Widget build(BuildContext context) {
    Widget renderApp() {
      return Scaffold(
        body: SizedBox.expand(
          child: widget.navigationShell,
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (int index) {
            setState(() {
              selectedIndex = index;
            });
            _goToBranch(selectedIndex);
          },
          destinations: [
            NavigationDestination(
              icon: FaIcon(FontAwesomeIcons.boxesStacked),
              label: 'Productos',
            ),
            NavigationDestination(
              icon: FaIcon(FontAwesomeIcons.receipt),
              label: 'Facturas',
            ),
            NavigationDestination(
              icon: FaIcon(FontAwesomeIcons.peopleGroup),
              label: 'Clientes',
            ),
            NavigationDestination(
              icon: FaIcon(FontAwesomeIcons.gear),
              label: 'Configuración',
            ),
          ],
        ),
      );
    }

    return RestorationScope(
      restorationId: 'home',
      child: isFirstOpen ? LoadingDialog("Cargando datos iniciales...") : renderApp(),
    );
  }
}
