import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_shelf/components/lists/product_list.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/delegates/product_search_delegate.dart';
import 'package:project_shelf/models/product.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  final String? restorationId;

  const ProductsScreen({this.restorationId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      restorationId: restorationId,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Productos'),
      ),
      body: TabBarView(
        children: [
          ProductList(),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => context.go('/products/create'),
            child: Icon(Icons.add),
          ),
          SizedBox.square(
            dimension: 10,
          ),
          FloatingActionButton(
            onPressed: () async => await showSearch<ProductData?>(
              context: context,
              delegate: ProductSearchDelegate(
                model: context.read<ProductModel>(),
              ),
            ),
            child: Icon(Icons.search_rounded),
          ),
        ],
      ),
    );
  }
}