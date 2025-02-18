import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/components/text_fields/custom_text_field.dart';
import 'package:project_shelf/providers/product.dart';
import 'package:project_shelf/providers/products.dart';
import 'package:project_shelf/utils/text_formatter.dart';

final productProvider = FutureProvider.autoDispose.family((ref, String id) {
  return ref.watch(productsProvider.selectAsync(
    (products) => products.firstWhere((product) => product.id == id),
  ));
});

final editFormProvider =
    FutureProvider.autoDispose.family((ref, String id) async {
  return ref.watch(productProvider(id)).whenData((product) {
    return ref.watch(ProductFormProvider(
        entity: Option.some(ProductEntity.fromData(product))));
  });
});

class ProductView extends ConsumerWidget {
  final String id;

  const ProductView({required this.id, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productProvider(id));
    final state = ref.watch(editFormProvider(id));

    Widget renderProductName() {
      return switch (product) {
        AsyncData(:final value) => Text(value.name),
        AsyncError(:final error) => Text("$error"),
        _ => Center(child: const CircularProgressIndicator.adaptive())
      };
    }

    Widget renderProduct() {
      return switch (product) {
        AsyncData(:final value) => Column(
            children: [
              CustomTextField(
                label: "Nombre",
                isRequired: true,
                initialValue: value.name,
                readOnly: true,
                keyboardType: TextInputType.text,
                inputFormatters: [UpperCaseTextFormatter()],
                textCapitalization: TextCapitalization.characters,
                textInputAction: TextInputAction.next,
                // onFocusChange: (hasFocus) {
                //   if (!hasFocus) {
                //     ref.read(productFormProvider.notifier).validate("name");
                //   }
                // },
                // onChanged: (value) {
                //   ref.read(productFormProvider.notifier).set("name", value);
                // },
                // errorText: state.entity.getError("name").toNullable(),
              ),
              CustomTextField(
                label: "Código",
                initialValue: value.code,
                readOnly: true,
              ),
            ],
          ),
        AsyncError(:final error) => Text("$error"),
        _ => Center(child: const CircularProgressIndicator.adaptive())
      };
    }

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: renderProductName()),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: renderProduct(),
      ),
    );
  }
}
