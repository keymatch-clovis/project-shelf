import 'package:flutter/material.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/models/product.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late Future future;

  @override
  void initState() {
    super.initState();
    future = context.read<ProductModel>().loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductModel>(
      builder: (context, model, child) => FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: model.products.length,
                prototypeItem: ListTile(title: _ListItem(0)),
                itemBuilder: (context, index) =>
                    ListTile(title: _ListItem(index)),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          }),
    );
  }
}

class _ListItem extends StatelessWidget {
  final int index;

  const _ListItem(this.index);

  @override
  Widget build(BuildContext context) {
    var item = context
        .select<ProductModel, ProductData>((model) => model.products[index]);

    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(item.name),
    );
  }
}
