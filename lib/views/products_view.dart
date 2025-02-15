import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/components/lists/product_list.dart';
import 'package:project_shelf/providers/products.dart';

class ProductsView extends ConsumerWidget {
  final String? restorationId;

  const ProductsView({this.restorationId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget renderProductList() {
      final asyncList = ref.watch(productsProvider);

      return switch (asyncList) {
        AsyncData(value: final list) => ProductList(
            list: list,
            onTap: (id) => context.go('/products/product/$id'),
          ),
        _ => Center(child: const CircularProgressIndicator.adaptive()),
      };
    }

    return Scaffold(
      restorationId: restorationId,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Productos'),
      ),
      body: SizedBox.expand(child: renderProductList()),
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
        ],
      ),
    );
  }
}
