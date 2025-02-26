import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/components/selectors/city_selector.dart';
import 'package:project_shelf/components/text_fields/custom_text_field.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/providers/customers.dart';
import 'package:project_shelf/util/text_formatter.dart';

final customerFuture = FutureProvider.autoDispose.family<CustomerData, String>(
    (ref, uuid) => ref.watch(customersProvider.selectAsync((customers) =>
        customers.firstWhere((customer) => customer.uuid == uuid))));

class EditCustomerView extends ConsumerStatefulWidget {
  final String uuid;

  const EditCustomerView({super.key, required this.uuid});

  @override
  EditCustomerViewState createState() => EditCustomerViewState();
}

class EditCustomerViewState extends ConsumerState<EditCustomerView> {
  final _formKey = GlobalKey<FormState>();

  late CustomerData editedCustomer;
  late AutoDisposeFutureProvider<CustomerData> provider;

  bool canEdit = false;

  @override
  void initState() {
    super.initState();

    provider = customerFuture(widget.uuid);
    ref.read(provider.future).then((customer) => editedCustomer = customer);
  }

  void edit(CustomerData editedData) async {
    final customer = await ref.watch(provider.future);

    setState(() {
      editedCustomer = editedData;
      canEdit = customer != editedCustomer && _formKey.currentState!.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    final customer = ref.watch(customerFuture(widget.uuid));

    if (customer.isLoading) {
      // TODO: This is ugly asf.
      canEdit = false;
      return Center(child: CircularProgressIndicator.adaptive());
    }

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Editar Cliente")),
      body: Container(
        margin: const EdgeInsets.all(18),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                isRequired: true,
                label: "Nombre del Cliente",
                inputFormatters: [UpperCaseTextFormatter()],
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.characters,
                keyboardType: TextInputType.name,
                initialValue: editedCustomer.name,
                onChanged: (text) => edit(editedCustomer.copyWith(name: text)),
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
                initialValue: editedCustomer.address,
                onChanged: (text) =>
                    edit(editedCustomer.copyWith(address: text)),
              ),
              CitySelector(
                cityRowId: editedCustomer.cityRowId,
                onTap: (rowId) =>
                    edit(editedCustomer.copyWith(cityRowId: rowId)),
              ),
              // CustomTextField(
              //   readOnly: true,
              //   label: "Teléfono",
              // ),
              // CustomTextField(
              //   readOnly: true,
              //   label: "Nombre del Negocio",
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: canEdit,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              disabledElevation: 0,
              onPressed: () =>
                  ref.read(customersProvider.notifier).replace(editedCustomer),
              child: FaIcon(FontAwesomeIcons.floppyDisk),
            ),
          ],
        ),
      ),
    );
  }
}
