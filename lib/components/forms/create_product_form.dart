import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:project_shelf/components/text_fields/currency_text_field.dart';
import 'package:project_shelf/components/text_fields/custom_text_field.dart';
import 'package:project_shelf/components/text_fields/number_text_field.dart';
import 'package:project_shelf/lib/custom_form_state.dart';
import 'package:project_shelf/lib/form_entry.dart';
import 'package:project_shelf/utils/text_formatter.dart';

class CreateProductForm extends StatefulWidget {
  final String? restorationId;
  final void Function(Map<String, FormEntry>) onSubmit;

  const CreateProductForm({
    required this.onSubmit,
    this.restorationId,
    super.key,
  });

  @override
  CreateProductFormState createState() => CreateProductFormState();
}

class CreateProductFormState extends State<CreateProductForm>
    with CustomFormState {

  @override
  var formState = {
    "name": FormEntry(
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
    ),
    "value": FormEntry(
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.min(0, checkNullOrEmpty: false),
      ]),
    ),
    "stock": FormEntry(
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.min(0, checkNullOrEmpty: false),
      ]),
    ),
    "code": FormEntry(),
  };

  @override
  Widget build(BuildContext context) {
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
                  validate("name");
                }
              },
              onChanged: (value) => update("name", value),
              errorText: formState["name"]!.error,
            ),
            CurrencyTextField(
              labelText: "Valor",
              onAccept: (value) => update("value", value.toString()),
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  validate("value");
                }
              },
              errorText: formState["value"]!.error,
            ),
            NumberTextField(
              labelText: "Cantidad",
              onAccept: (value) => update("stock", value.toString()),
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  validate("stock");
                }
              },
              errorText: formState["stock"]!.error,
            ),
            CustomTextField(
              labelText: 'Código',
              keyboardType: TextInputType.text,
              inputFormatters: [UpperCaseTextFormatter()],
              textCapitalization: TextCapitalization.characters,
              onChanged: (value) => update("code", value),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                if (validateAll()) {
                  widget.onSubmit(formState);
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
