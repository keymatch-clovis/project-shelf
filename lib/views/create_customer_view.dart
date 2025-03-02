import "package:drift/drift.dart" as drift;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/components/selectors/city_selector.dart';
import 'package:project_shelf/components/text_fields/custom_text_field.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/providers/customers.dart';
import 'package:project_shelf/util/text_formatter.dart';

class CreateCustomerView extends HookConsumerWidget {
  final String? restorationId;

  const CreateCustomerView({this.restorationId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useState(GlobalKey<FormState>());

    final name = useState("");
    final phone = useState("");
    final address = useState("");
    final cityRowId = useState<int?>(null);
    final businessName = useState<String?>(null);

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Crear Cliente")),
      body: Container(
        margin: const EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Form(
            key: formKey.value,
            child: Column(
              children: [
                CustomTextField(
                  isRequired: true,
                  label: "Nombre del Cliente",
                  inputFormatters: [UpperCaseTextFormatter()],
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.characters,
                  keyboardType: TextInputType.name,
                  onChanged: (text) => name.value = text,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                CustomTextField(
                  isRequired: true,
                  label: "Dirección",
                  inputFormatters: [UpperCaseTextFormatter()],
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.characters,
                  keyboardType: TextInputType.streetAddress,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  onChanged: (text) => address.value = text,
                ),
                CitySelector(
                  isRequired: true,
                  cityRowId: cityRowId.value,
                  onTap: (id) {
                    cityRowId.value = id;
                    FocusScope.of(context).nextFocus();
                  },
                ),
                CustomTextField(
                  isRequired: true,
                  label: "Teléfono",
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  onChanged: (text) => phone.value = text,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.phoneNumber(),
                  ]),
                ),
                CustomTextField(
                  label: "Nombre del Negocio",
                  inputFormatters: [UpperCaseTextFormatter()],
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.characters,
                  keyboardType: TextInputType.name,
                  onChanged: (text) {
                    businessName.value = text.trim().isEmpty ? null : text;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            disabledElevation: 0,
            onPressed: () async {
              if (formKey.value.currentState!.validate()) {
                await ref.read(customersProvider.notifier).create(
                      CustomerCompanion.insert(
                        name: name.value,
                        phone: phone.value,
                        address: address.value,
                        cityRowId: cityRowId.value!,
                        businessName:
                            drift.Value.absentIfNull(businessName.value),
                      ),
                    );

                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              }
            },
            child: FaIcon(FontAwesomeIcons.floppyDisk),
          ),
        ],
      ),
    );
  }
}
