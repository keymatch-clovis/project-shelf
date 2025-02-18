import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:project_shelf/components/text_fields/custom_text_field.dart";
import "package:project_shelf/providers/product.dart";
import "package:project_shelf/utils/text_formatter.dart";

class CreateProductForm extends ConsumerWidget {
  final String? restorationId;
  final Function(Map<String, String>) onSubmit;

  const CreateProductForm({
    required this.onSubmit,
    this.restorationId,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productFormProvider());

    return Form(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomTextField(
              label: "Nombre del Producto",
              isRequired: true,
              autofocus: true,
              inputFormatters: [UpperCaseTextFormatter()],
              textCapitalization: TextCapitalization.characters,
              onChanged: (value) {
                ref.read(productFormProvider().notifier).set("name", value);
              },
              error: state.entity.getError("name"),
            ),
            CustomTextField(
              label: "Precio Inicial",
              keyboardType: TextInputType.numberWithOptions(),
              onChanged: (value) {
                ref.read(productFormProvider().notifier).set("value", value);
              },
              error: state.entity.getError("value"),
            ),
            CustomTextField(
              label: "Cantidad en Inventario",
              keyboardType: TextInputType.numberWithOptions(),
              onChanged: (value) {
                ref.read(productFormProvider().notifier).set("stock", value);
              },
              error: state.entity.getError("stock"),
            ),
            CustomTextField(
              label: "Código",
              inputFormatters: [UpperCaseTextFormatter()],
              textCapitalization: TextCapitalization.characters,
              textInputAction: TextInputAction.done,
              onChanged: (value) {
                ref.read(productFormProvider().notifier).set("code", value);
              },
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                ref.read(productFormProvider().notifier).validateAll();
                if (state.entity.isValid) {
                  onSubmit(
                    state.entity.fields.map(
                      (key, field) => MapEntry(key, field.value),
                    ),
                  );
                }
              },
              child: const Text("CREAR PRODUCTO"),
            ),
          ],
        ),
      ),
    );
  }
}
