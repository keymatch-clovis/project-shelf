import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/providers/customers.dart';

class DataLoadView extends ConsumerWidget {
  const DataLoadView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Cargar Datos"),
      ),
      body: Container(
          margin: const EdgeInsets.all(18),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: [
              _Button(
                title: "Cargar Productos",
                icon: FontAwesomeIcons.boxesStacked,
                onTap: () {},
              ),
              _Button(
                title: "Cargar Facturas",
                icon: FontAwesomeIcons.receipt,
                onTap: () {},
              ),
              _Button(
                title: "Cargar Clientes",
                icon: FontAwesomeIcons.peopleGroup,
                onTap: () => ref.read(customersProvider.notifier).TEST_load(),
              ),
            ],
          )),
    );
  }
}

class _Button extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;

  const _Button({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        title: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(size: 32, icon),
              const SizedBox(height: 8),
              Text(title),
            ],
          ),
        ),
        onTap: () => onTap(),
      ),
    );
  }
}
