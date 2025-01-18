import 'package:flutter/material.dart';
import 'package:project_shelf/components/forms/create_product_form.dart';
import 'package:project_shelf/models/product.dart';
import 'package:provider/provider.dart';

class CreateProduct extends StatelessWidget {
  final String? restorationId;

  const CreateProduct({this.restorationId, super.key});

  static Page<void> pageBuilder(BuildContext context) {
    return const MaterialPage(
      restorationId: 'router.create.product',
      child: CreateProduct(
        restorationId: 'create.product',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RestorationScope(
        restorationId: restorationId,
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(items: [
            BottomNavigationBarItem(icon: Icon(Icons.outbox), label: 'test'),
            BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'tester'),
          ]),
          body: CreateProductForm(),
        ));
  }
}
