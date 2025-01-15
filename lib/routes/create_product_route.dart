import 'package:flutter/material.dart';
import 'package:project_shelf/components/forms/create_product_form.dart';

class CreateProductRoute extends StatefulWidget {
  const CreateProductRoute({super.key});

  @override
  State<CreateProductRoute> createState() => _CreateProductRouteState();
}

class _CreateProductRouteState extends State<CreateProductRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Crear Producto')),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[const CreateProductForm()],
        )));
  }
}
