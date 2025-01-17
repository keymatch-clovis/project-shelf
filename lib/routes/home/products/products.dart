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
      appBar: AppBar(title: const Text("Products"),),
      body: TabBarView(children: [
        ProductList(),
      ]),
    );
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
      body: Column(
        children: <Widget>[],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/home/products/create'),
        child: Icon(Icons.add),
      ),
    );
  }
}
