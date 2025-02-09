import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/components/lists/product_list.dart';
import 'package:project_shelf/providers/products.dart';

class ProductsView extends ConsumerWidget {
  final String? restorationId;

  const ProductsView({this.restorationId, super.key});

  Widget renderProductList(BuildContext context, WidgetRef ref) {
    final asyncList = ref.watch(productsProvider);

    return switch (asyncList) {
      AsyncData(value: final list) => ProductList(
          list: list,
          onTapProduct: (id) => context.go('/products/product/$id'),
        ),
      _ => Center(child: const CircularProgressIndicator.adaptive()),
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      restorationId: restorationId,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Productos'),
      ),
      body: SizedBox.expand(child: renderProductList(context, ref)),
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
