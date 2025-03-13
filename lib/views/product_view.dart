import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/components/dialog/accept_dialog.dart';
import 'package:project_shelf/components/dialog/loading_dialog.dart';
import 'package:project_shelf/components/text_fields/custom_text_field.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/lib/constants.dart';
import 'package:project_shelf/lib/cop_currency.dart';
import 'package:project_shelf/providers/product/product_mementos.dart';
import 'package:project_shelf/providers/product/products.dart';

class ProductView extends HookConsumerWidget {
  final ProductData _product;

  const ProductView(this._product, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = useState(_product);

    useEffect(() {
      product.value = _product;
      return null;
    }, [_product]);

    void delete() async {
      final result = await showDialog(
        context: context,
        useRootNavigator: true,
        builder: (_) => AcceptDialog("¿Estás seguro?"),
      );

      if (result != null && result) {
        final result = await withLoading(
            // ignore: use_build_context_synchronously
            context: context,
            message: "Eliminando...", () async {
          return await ref
              .read(productsProvider.notifier)
              .delete(_product.uuid);
        });

        result.match(
          (_) => context.go("/products"),
          (err) => err.showSnackBar(context),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(product.value.name)),
      body: Container(
        color: Colors.white,
        padding: EI_16,
        child: Column(
          children: [
            CustomTextField(
              readOnly: true,
              label: "Nombre del Producto",
              initialValue: product.value.name,
            ),
            CustomTextField(
              readOnly: true,
              label: "Precio por Defecto",
              initialValue:
                  CopCurrency.fromCents(product.value.price).formattedValue,
            ),
            CustomTextField(
              readOnly: true,
              label: "Cantidad en Inventario",
              initialValue: product.value.stock.toString(),
            ),
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: STONE_500),
                    borderRadius: ROUNDED_MD,
                  ),
                  child: Column(
                    children: [
                      const TabBar(tabs: [
                        Tab(icon: FaIcon(FontAwesomeIcons.receipt)),
                        Tab(icon: FaIcon(FontAwesomeIcons.clockRotateLeft)),
                      ]),
                      Expanded(
                        child: TabBarView(
                          children: [
                            FaIcon(FontAwesomeIcons.solidFontAwesome),
                            MementosList(product.value),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
              FloatingActionButton(
                heroTag: null,
                onPressed: delete,
                child: FaIcon(FontAwesomeIcons.solidTrashCan),
              ),
              const SizedBox(width: 12),
              FloatingActionButton(
                heroTag: null,
                onPressed: () => context.go(
                  "/products/product/edit",
                  extra: _product,
                ),
                child: FaIcon(FontAwesomeIcons.pen),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MementosList extends ConsumerWidget {
  final ProductData product;
  const MementosList(this.product, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mementos = ref.watch(productMementosProvider(product.uuid));

    return switch (mementos) {
      AsyncData(:final value) => renderList(value),
      AsyncError(:final error) => Text("error: $error"),
      _ => const Center(child: CircularProgressIndicator.adaptive()),
    };
  }

  Widget renderList(ProductMementosState state) {
    return Text(state.mementos.length.toString());
  }
}
