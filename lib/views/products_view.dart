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
        title: Text(
          'Productos',
          style: TEXT_GREEN_800.merge(FONT_BOLD),
        ),
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
      return Center(child: Text("Sin productos", style: TEXT_STONE_600));
    }

    return ListView.separated(
      itemCount: list.length,
      separatorBuilder: (_, __) => Divider(height: 0),
      itemBuilder: (context, index) => _ListItem(list[index]),
    );
  }
}

class _ListItem extends StatelessWidget {
  final ProductData item;

  const _ListItem(this.item);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.go("/products/product", extra: item),
      tileColor: Colors.white,
      title: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: TEXT_SM),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Pill(
                iconData: FontAwesomeIcons.xmark,
                color: STONE_200,
                textColor: STONE_600,
                text: item.stock > 9999 ? "9999" : item.stock.toString(),
              ),
              const SizedBox(width: W3XS),
              Text(
                CopCurrency.fromCents(item.price).formattedValue,
                style: TEXT_LG.merge(FONT_BOLD),
              ),
            ],
          ),
          const SizedBox(width: WSM),
          FaIcon(FontAwesomeIcons.chevronRight),
        ],
      ),
    );
  }
}
