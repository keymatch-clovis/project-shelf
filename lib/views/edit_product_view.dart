import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/components/text_fields/custom_text_field.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/lib/cop_currency.dart';
import 'package:project_shelf/providers/product/products.dart';
import 'package:project_shelf/util/text_formatter.dart';

class EditProductView extends HookConsumerWidget {
  final ProductData _product;

  const EditProductView(this._product, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useState(GlobalKey<FormState>());
    final editedProduct = useState(_product.copyWith());

    final canEdit = useState(false);
    useEffect(() {
      canEdit.value = editedProduct.value != _product &&
          formKey.value.currentState!.validate();
      return null;
    }, [editedProduct.value]);

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Editar Producto")),
      backgroundColor: Colors.white,
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
                  editedProduct.value =
                      editedProduct.value.copyWith(name: text);
                },
                initialValue: _product.name,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              CustomTextField(
                label: "Precio por Defecto",
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  editedProduct.value = editedProduct.value.copyWith(
                    price: text.trim().isEmpty
                        ? null
                        : CopCurrency(text).realValue,
                  );
                },
                initialValue: CopCurrency.fromCents(_product.price).rawValue,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.numeric(checkNullOrEmpty: false),
                  FormBuilderValidators.min(0, checkNullOrEmpty: false),
                ]),
              ),
              CustomTextField(
                label: "Cantidad en Inventario",
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  editedProduct.value = editedProduct.value.copyWith(
                    stock: text.trim().isEmpty ? null : int.parse(text),
                  );
                },
                initialValue: _product.stock.toString(),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.numeric(checkNullOrEmpty: false),
                ]),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: canEdit.value,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              disabledElevation: 0,
              onPressed: () async {
                await ref
                    .read(productsProvider.notifier)
                    .replace(editedProduct.value);

                if (context.mounted) {
                  context.go("/products/product",
                      extra: await ref
                          .read(productsProvider.future)
                          .then((products) {
                        return products.firstWhere((product) {
                          return product.uuid == _product.uuid;
                        });
                      }));
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
