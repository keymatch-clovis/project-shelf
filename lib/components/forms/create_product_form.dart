import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/components/text_fields/currency_text_field.dart';
import 'package:project_shelf/components/text_fields/custom_text_field.dart';
import 'package:project_shelf/components/text_fields/number_text_field.dart';
import 'package:project_shelf/providers/product.dart';
import 'package:project_shelf/utils/text_formatter.dart';

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
              labelText: 'Nombre',
              keyboardType: TextInputType.text,
              inputFormatters: [UpperCaseTextFormatter()],
              textCapitalization: TextCapitalization.characters,
              textInputAction: TextInputAction.next,
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  ref.read(productFormProvider().notifier).validate("name");
                }
              },
              onChanged: (value) {
                ref.read(productFormProvider().notifier).set("name", value);
              },
              errorText: state.entity.getError("name").toNullable(),
            ),
            CurrencyTextField(
              labelText: "Valor",
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  ref.read(productFormProvider().notifier).validate("value");
                }
              },
              onAccept: (value) {
                ref
                    .read(productFormProvider().notifier)
                    .set("value", value.toString());
              },
              errorText: state.entity.getError("value").toNullable(),
            ),
            NumberTextField(
              labelText: "Cantidad",
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  ref.read(productFormProvider().notifier).validate("value");
                }
              },
              onAccept: (value) {
                ref
                    .read(productFormProvider().notifier)
                    .set("value", value.toString());
              },
            ),
            CustomTextField(
              labelText: 'Código',
              keyboardType: TextInputType.text,
              inputFormatters: [UpperCaseTextFormatter()],
              textCapitalization: TextCapitalization.characters,
              onChanged: (value) {
                ref.read(productFormProvider().notifier).set("code", value);
              },
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                if (state.entity.isValid) {
                  onSubmit(
                    state.entity.fields.map(
                      (key, field) => MapEntry(key, field.value),
                    ),
                  );
                }
              },
              child: const Text('CREAR PRODUCTO'),
            ),
          ],
        ),
      ),
    );
  }
}
