import 'package:flutter/material.dart';

class Destination {
  final int index;
  final String title;
  final IconData icon;

  const Destination(this.index, this.title, this.icon);
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const List<Destination> destinations = <Destination>[
    Destination(0, 'Productos', Icons.category_rounded),
    Destination(1, 'Ventas', Icons.receipt_rounded),
    Destination(2, 'Clientes', Icons.people_rounded),
  ];

  late final List<GlobalKey<NavigatorState>> navigatorKeys;
  late final List<GlobalKey> destinationKeys;
  late final List<Widget> destinationViews;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    navigatorKeys = List<GlobalKey<NavigatorState>>.generate(
      destinations.length,
      (int index) => GlobalKey(),
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return RestorationScope(
      restorationId: 'home',
      child: NavigatorPopHandler(
        child: Scaffold(
          body: SafeArea(
            top: false,
            child: Stack(
              fit: StackFit.expand,
              children: destinations.map((destination) {
                final int index = destination.index;
                final Widget view = destinationViews[index];
                return Offstage(child: view);
              }).toList(),
            ),
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                selectedIndex = index;
              });
            },
            destinations: destinations
                .map(
                  (destination) => NavigationDestination(
                    icon: Icon(destination.icon),
                    label: destination.title,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
