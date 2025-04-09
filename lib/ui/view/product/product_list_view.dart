import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import 'package:project_shelf/providers.dart';
import 'package:project_shelf/shared/constants.dart';
import 'package:project_shelf/ui/components/product_list.dart';

class ProductListView extends ConsumerWidget {
  const ProductListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(productListViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Productos',
          style: TEXT_GREEN_800.merge(FONT_BOLD),
        ),
      ),
      body: ProductList(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: BORDER_T,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Padding(
          padding: P_8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ProductSearchAnchor(
              //   builder: (context, controller) {
              //     return FloatingActionButton(
              //       heroTag: null,
              //       child: FaIcon(FontAwesomeIcons.magnifyingGlass),
              //       onPressed: () => controller.openView(),
              //     );
              //   },
              //   onTap: (product) => context.go(
              //     "/products/product",
              //     extra: product,
              //   ),
              // ),
              const SizedBox(width: W3XS),
              FloatingActionButton(
                heroTag: null,
                onPressed: () => context.go('/products/create'),
                child: FaIcon(FontAwesomeIcons.plus),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
