import 'package:flutter/material.dart';
import 'package:project_shelf/components/forms/create_product_form.dart';

class CreateProductScreen extends StatelessWidget {
  final String? restorationId;

  const CreateProductScreen({this.restorationId, super.key});

  @override
  Widget build(BuildContext context) {
    return RestorationScope(
      restorationId: restorationId,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Crear Producto'),
        ),
        body: CreateProductForm(),
      ),
    );
  }
}
