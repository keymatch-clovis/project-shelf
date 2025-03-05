import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/components/pill.dart';
import 'package:project_shelf/components/product_search_anchor.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/lib/cop_currency.dart';
import 'package:project_shelf/providers/product/products.dart';

class ProductsView extends ConsumerWidget {
  final String? restorationId;

  const ProductsView({this.restorationId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      restorationId: restorationId,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Productos'),
      ),
      body: _ProductList(),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        ProductSearchAnchor(
          builder: (context, controller) {
            return FloatingActionButton(
              heroTag: null,
              child: FaIcon(FontAwesomeIcons.magnifyingGlass),
              onPressed: () => controller.openView(),
            );
          },
          onTap: (product) => context.go(
            "/products/product",
            extra: product,
          ),
        ),
        const SizedBox(width: 12),
        FloatingActionButton(
          heroTag: null,
          onPressed: () => context.go('/products/create'),
          child: FaIcon(FontAwesomeIcons.plus),
        ),
      ],
    );
  }
}

class _ProductList extends ConsumerWidget {
  Widget renderList(List<ProductData> list) {
    if (list.isEmpty) {
      return Center(child: Text("Sin productos"));
    }

    return ListView.separated(
      itemCount: list.length,
      separatorBuilder: (_, __) => Divider(),
      itemBuilder: (context, index) => ListTile(
        title: _ListItem(list[index]),
        onTap: () => context.go("/products/product", extra: list[index]),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customers = ref.watch(productsProvider);

    return switch (customers) {
      AsyncData(:final value) => renderList(value),
      AsyncError(:final error) => Text("error: $error"),
      _ => const Center(child: CircularProgressIndicator.adaptive()),
    };
  }
}

class _ListItem extends StatelessWidget {
  final ProductData data;

  const _ListItem(this.data);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.name),
                    Text(
                      CopCurrency.fromCents(data.price).formattedValue,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Pill(
                    iconData: FontAwesomeIcons.box,
                    text: data.stock.toString(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
