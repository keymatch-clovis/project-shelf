import 'package:flutter/material.dart';
import 'package:project_shelf/models/product_list_model.dart';
import 'package:project_shelf/models/product_model.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late Future fetchProducts;

  @override
  void initState() {
    super.initState();
    print('loading products in list...');
    fetchProducts = context.read<ProductListModel>().loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<ProductListModel>(
        builder: (context, model, child) => FutureBuilder(
            future: fetchProducts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (model.products.isNotEmpty) {
                  return ListView.builder(
                    itemCount: model.products.length,
                    prototypeItem: ListTile(title: _ListItem(0)),
                    itemBuilder: (context, index) =>
                        ListTile(title: _ListItem(index)),
                  );
                } else {
                  return const Text("No products.");
                }
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            }),
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final int index;

  const _ListItem(this.index);

  @override
  Widget build(BuildContext context) {
    var item = context.select<ProductListModel, ProductModel>(
        (model) => model.products[index]);

    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(item.name),
    );
  }
}
