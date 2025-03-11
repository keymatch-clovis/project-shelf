import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/components/pill.dart';
import 'package:project_shelf/components/product_search_anchor.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/lib/constants.dart';
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
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);

    return switch (products) {
      AsyncData(:final value) => renderList(value),
      AsyncError(:final error) => Text("error: $error"),
      _ => const Center(child: CircularProgressIndicator.adaptive()),
    };
  }

  Widget renderList(List<ProductData> list) {
    if (list.isEmpty) {
      return Center(child: Text("Sin productos"));
    }

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) => Card(
        elevation: 1,
        margin: EdgeInsets.symmetric(horizontal: M10, vertical: M4),
        child: ListTile(
          onTap: () => context.go("/products/product", extra: list[index]),
          title: _ListItem(list[index]),
        ),
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final ProductData data;

  const _ListItem(this.data);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.name, style: TEXT_SM),
                  const SizedBox(height: H8),
                  Row(
                    children: [
                      Pill(
                        iconData: FontAwesomeIcons.box,
                        color: STONE200,
                        width: W96,
                        textColor: STONE600,
                        text: data.stock > 9999
                            ? "+9999"
                            : data.stock.toString(),
                      ),
                      const SizedBox(width: W3XS),
                      Pill(
                        iconData: FontAwesomeIcons.dollarSign,
                        color: STONE200,
                        textColor: STONE600,
                        text: CopCurrency.fromCents(data.price).formattedValue,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            FaIcon(FontAwesomeIcons.chevronRight),
          ],
        ),
      ],
    );
  }
}
