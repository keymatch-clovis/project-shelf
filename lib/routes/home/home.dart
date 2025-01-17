import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Home extends StatelessWidget {
  final String? restorationId;
  final Widget child;
  final void Function(int) onTap;

  const Home({
    required this.child,
    required this.onTap,
    this.restorationId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final index = _getSelectedIndex(GoRouterState.of(context).uri.toString());
    return RestorationScope(
      restorationId: restorationId,
      child: DefaultTabController(
        initialIndex: index,
        length: 1,
        child: Card(
          child: Column(
            children: [
              Expanded(child: child),
              TabBar(
                onTap: onTap,
                tabs: const [
                  Tab(
                    icon: Icon(Icons.home),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

int _getSelectedIndex(String location) {
  if (location.startsWith('/products')) return 0;
  return 0;
}
