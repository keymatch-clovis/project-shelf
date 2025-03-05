import "package:drift/drift.dart" as drift;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/components/text_fields/custom_text_field.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/lib/cop_currency.dart';
import 'package:project_shelf/providers/product/products.dart';
import 'package:project_shelf/util/text_formatter.dart';

class CreateProductView extends HookConsumerWidget {
  final String? restorationId;

  const CreateProductView({this.restorationId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useState(GlobalKey<FormState>());

    final name = useState("");
    final price = useState<String?>(null);
    final stock = useState<String?>(null);
    final code = useState<String?>(null);

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Crear Producto")),
      body: Container(
        margin: const EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Form(
            key: formKey.value,
            child: Column(
              children: [
                CustomTextField(
                  isRequired: true,
                  label: "Nombre del Producto",
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
                  label: "Precio por Defecto",
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.numeric(checkNullOrEmpty: false),
                    FormBuilderValidators.min(0, checkNullOrEmpty: false),
                  ]),
                  onChanged: (text) {
                    price.value = text.trim().isEmpty ? null : text;
                  },
                ),
                CustomTextField(
                  label: "Cantidad en Inventario",
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.numeric(checkNullOrEmpty: false),
                  ]),
                  onChanged: (text) {
                    stock.value = text.trim().isEmpty ? null : text;
                  },
                ),
                CustomTextField(
                  label: "Código del Producto",
                  inputFormatters: [UpperCaseTextFormatter()],
                  textCapitalization: TextCapitalization.characters,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  onChanged: (text) {
                    code.value = text.trim().isEmpty ? null : text;
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
                await ref
                    .read(productsProvider.notifier)
                    .create(ProductCompanion.insert(
                      name: name.value,
                      price: drift.Value.absentIfNull(
                        price.value != null
                            ? CopCurrency(price.value!).realValue
                            : null,
                      ),
                      stock: drift.Value.absentIfNull(
                        stock.value != null ? int.parse(stock.value!) : null,
                      ),
                    ));

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
