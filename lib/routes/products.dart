import 'package:flutter/material.dart';
import 'package:project_shelf/components/lists/product_list.dart';
import 'package:project_shelf/models/product_list_model.dart';
import 'package:provider/provider.dart';

class Products extends StatelessWidget {
  const Products({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Products"),
      ),
      body: ChangeNotifierProvider(
        create: (context) => ProductListModel(),
        child: Column(
          children: <Widget>[ProductList()],
        ),
      ),
    );
  }
}
