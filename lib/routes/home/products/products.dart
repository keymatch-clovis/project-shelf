import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_shelf/components/lists/product_list.dart';

class Products extends StatelessWidget {
  final String? restorationId;

  const Products({this.restorationId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      restorationId: restorationId,
      body: TabBarView(children: [
        ProductList(),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/products/create'),
        child: Icon(Icons.add),
      ),
    );
  }
}
