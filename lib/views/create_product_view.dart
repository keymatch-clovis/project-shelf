import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/components/forms/create_product_form.dart';
import 'package:project_shelf/providers/products.dart';

class CreateProductView extends ConsumerWidget {
  final String? restorationId;

  const CreateProductView({this.restorationId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RestorationScope(
      restorationId: restorationId,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Crear Producto'),
        ),
        body: CreateProductForm(
          restorationId: 'create.product.form',
          onSubmit: (data) async {
            await ref.read(productsProvider.notifier).add(data);
            if (context.mounted) {
              context.go("/products");
            }
          },
        ),
      ),
    );
  }
}
