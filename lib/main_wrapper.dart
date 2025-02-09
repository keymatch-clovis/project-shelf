import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class MainWrapper extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainWrapper({super.key, required this.navigationShell});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int selectedIndex = 0;

  void _goToBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RestorationScope(
      restorationId: 'home',
      child: Scaffold(
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
                icon: FaIcon(FontAwesomeIcons.boxesStacked), label: 'Productos'),
            NavigationDestination(
                icon: FaIcon(FontAwesomeIcons.receipt), label: 'Facturas'),
            NavigationDestination(
                icon: FaIcon(FontAwesomeIcons.peopleGroup), label: 'Clientes'),
          ],
        ),
      ),
    );
  }
}
