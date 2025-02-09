import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/components/text_fields/currency_text_field.dart';
import 'package:project_shelf/components/text_fields/custom_text_field.dart';
import 'package:project_shelf/providers/create_product_form.dart';
import 'package:project_shelf/utils/text_formatter.dart';

class CreateProductForm extends ConsumerWidget {
  final String? restorationId;
  final void Function(Map<String, String?>) onSubmit;

  const CreateProductForm({
    required this.onSubmit,
    this.restorationId,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(
      createProductFormProvider.select((form) => form["value"]!.value),
    );

    return Form(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomTextField(
              labelText: 'Nombre',
              keyboardType: TextInputType.text,
              inputFormatters: [UpperCaseTextFormatter()],
              textCapitalization: TextCapitalization.characters,
              textInputAction: TextInputAction.next,
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  ref.read(createProductFormProvider.notifier).validate("name");
                }
              },
              onChanged: (value) => ref
                  .read(createProductFormProvider.notifier)
                  .update("name", value),
              errorText: ref.watch(
                createProductFormProvider.select((form) => form["name"]!.error),
              ),
            ),
            CurrencyTextField(
              labelText: "Valor",
              onAccept: (realValue) {
                ref
                    .read(createProductFormProvider.notifier)
                    .update("value", realValue);
              },
            ),
            CustomTextField(
              labelText: 'Código',
              keyboardType: TextInputType.text,
              inputFormatters: [UpperCaseTextFormatter()],
              textCapitalization: TextCapitalization.characters,
              onChanged: (value) => ref
                  .read(createProductFormProvider.notifier)
                  .update("code", value),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: null,
              child: const Text('CREAR PRODUCTO'),
            ),
          ],
        ),
      ),
    );
  }
}
