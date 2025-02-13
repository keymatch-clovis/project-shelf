import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:project_shelf/components/text_fields/custom_text_field.dart';
import 'package:project_shelf/lib/custom_form_state.dart';
import 'package:project_shelf/lib/form_entry.dart';
import 'package:project_shelf/utils/text_formatter.dart';

class CreateClientForm extends StatefulWidget {
  final String? restorationId;
  final void Function(Map<String, FormEntry>) onSubmit;

  const CreateClientForm({
    required this.onSubmit,
    this.restorationId,
    super.key,
  });

  @override
  CreateClientFormState createState() => CreateClientFormState();
}

class CreateClientFormState extends State<CreateClientForm>
    with CustomFormState {
  @override
  var formState = {
    "name": FormEntry(
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
    ),
    "document": FormEntry(
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
    ),
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
            CustomTextField(
              labelText: 'Documento',
              keyboardType: TextInputType.text,
              inputFormatters: [UpperCaseTextFormatter()],
              textCapitalization: TextCapitalization.characters,
              textInputAction: TextInputAction.next,
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  validate("document");
                }
              },
              onChanged: (value) => update("document", value),
              errorText: formState["document"]!.error,
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                if (validateAll()) {
                  widget.onSubmit(formState);
                }
              },
              child: const Text('CREAR CLIENTE'),
            ),
          ],
        ),
      ),
    );
  }
}
