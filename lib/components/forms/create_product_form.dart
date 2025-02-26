import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:project_shelf/components/text_fields/custom_text_field.dart";
import "package:project_shelf/database/database.dart";
import "package:project_shelf/util/text_formatter.dart";

class CreateProductForm extends ConsumerWidget {
  final String? restorationId;
  final Function(ProductCompanion data) onSubmit;

  const CreateProductForm({
    required this.onSubmit,
    this.restorationId,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            // CustomTextField(
            //   label: "Nombre del Producto",
            //   isRequired: true,
            //   autofocus: true,
            //   inputFormatters: [UpperCaseTextFormatter()],
            //   textCapitalization: TextCapitalization.characters,
            // ),
            // CustomTextField(
            //   label: "Precio Inicial",
            //   keyboardType: TextInputType.numberWithOptions(),
            // ),
            // CustomTextField(
            //   label: "Cantidad en Inventario",
            //   keyboardType: TextInputType.numberWithOptions(),
            // ),
            // CustomTextField(
            //   label: "Código",
            //   inputFormatters: [UpperCaseTextFormatter()],
            //   textCapitalization: TextCapitalization.characters,
            //   textInputAction: TextInputAction.done,
            // ),
            Spacer(),
            ElevatedButton(
              onPressed: () {},
              child: const Text("CREAR PRODUCTO"),
            ),
          ],
        ),
      ),
    );
  }
}
