import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/components/selectors/city_selector.dart';
import 'package:project_shelf/components/text_fields/custom_text_field.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/providers/customers.dart';
import 'package:project_shelf/util/text_formatter.dart';

class EditCustomerView extends HookConsumerWidget {
  final CustomerData _customer;

  const EditCustomerView(this._customer, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useState(GlobalKey<FormState>());
    final editedCustomer = useState(_customer.copyWith());

    final canEdit = useState(false);
    useEffect(() {
      canEdit.value = editedCustomer.value != _customer &&
          formKey.value.currentState!.validate();
      return null;
    }, [editedCustomer.value]);

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Editar Cliente")),
      body: Container(
        margin: const EdgeInsets.all(18),
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
                onChanged: (text) {
                  editedCustomer.value =
                      editedCustomer.value.copyWith(name: text);
                },
                initialValue: _customer.name,
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
                onChanged: (text) {
                  editedCustomer.value =
                      editedCustomer.value.copyWith(address: text);
                },
                initialValue: _customer.address,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              CitySelector(
                cityRowId: editedCustomer.value.cityRowId,
                isRequired: true,
                onTap: (cityRowId) {
                  editedCustomer.value =
                      editedCustomer.value.copyWith(cityRowId: cityRowId);
                },
              ),
              CustomTextField(
                isRequired: true,
                label: "Teléfono",
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                onChanged: (text) {
                  editedCustomer.value =
                      editedCustomer.value.copyWith(phone: text);
                },
                initialValue: _customer.phone,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.phoneNumber(),
                ]),
              ),
              CustomTextField(
                label: "Nombre del Negocio",
                inputFormatters: [UpperCaseTextFormatter()],
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.characters,
                keyboardType: TextInputType.name,
                onChanged: (text) {
                  editedCustomer.value = editedCustomer.value.copyWith(
                    businessName: drift.Value(
                      text.trim().isEmpty ? null : text,
                    ),
                  );
                },
                initialValue: _customer.businessName,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: canEdit.value,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              disabledElevation: 0,
              onPressed: () async {
                await ref
                    .read(customersProvider.notifier)
                    .replace(editedCustomer.value);

                if (context.mounted) {
                  context.go("/customers/customer",
                      extra: await ref
                          .read(customersProvider.future)
                          .then((customers) {
                        return customers.firstWhere((data) {
                          return data.customer.uuid == _customer.uuid;
                        });
                      }).then((c) => c.customer));
                }
              },
              child: FaIcon(FontAwesomeIcons.floppyDisk),
            ),
          ],
        ),
      ),
    );
  }
}
