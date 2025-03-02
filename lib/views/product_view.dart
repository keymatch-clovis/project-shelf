import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/components/text_fields/custom_text_field.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/lib/cop_currency.dart';
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

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(product.value.name)),
      body: Container(
        margin: const EdgeInsets.all(18),
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
            CustomTextField(
              readOnly: true,
              label: "Código del Producto",
              initialValue: product.value.code,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: null,
            onPressed: () async {
              final result = await showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("¿Estás seguro?"),
                        ElevatedButton(
                          onPressed: () {
                            context.go("/products");
                          },
                          child: const Text("Eliminar"),
                        )
                      ],
                    ),
                  ),
                ),
              );

              if (result != null && result) {
                await ref.read(productsProvider.notifier).delete(_product.uuid);

                if (context.mounted) {
                  context.go("/products");
                }
              }
            },
            child: FaIcon(FontAwesomeIcons.trashCan),
          ),
          const SizedBox(height: 10),
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
    );
  }
}
