import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:project_shelf/shared/presentation/widgets/text_fields/custom_text_field.dart';
import 'package:project_shelf/lib/cop_currency.dart';
import 'package:project_shelf/providers/invoice/invoices.dart';

class CreateInvoiceProductDialog extends HookWidget {
  final InvoiceProduct _invoiceProduct;

  const CreateInvoiceProductDialog(this._invoiceProduct, {super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useState(GlobalKey<FormState>());
    final invoiceProduct = useState(_invoiceProduct);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: formKey.value,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(invoiceProduct.value.product.name),
              CustomTextField(
                isRequired: true,
                label: "Precio de Venta",
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(checkNullOrEmpty: false),
                  FormBuilderValidators.min(0, checkNullOrEmpty: false),
                ]),
                initialValue:
                    invoiceProduct.value.price.realValue > BigInt.from(0)
                        ? invoiceProduct.value.price.rawValue
                        : null,
                onChanged: (text) {
                  invoiceProduct.value.price = CopCurrency(text);
                },
              ),
              CustomTextField(
                isRequired: true,
                label: "Cantidad",
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(checkNullOrEmpty: false),
                  FormBuilderValidators.min(1, checkNullOrEmpty: false),
                ]),
                initialValue: invoiceProduct.value.count > 0
                    ? invoiceProduct.value.count.toString()
                    : null,
                onChanged: (text) {
                  invoiceProduct.value.count = int.parse(text);
                },
              ),
              CustomTextField(
                label: "Descuento",
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.numeric(checkNullOrEmpty: false),
                  FormBuilderValidators.min(0, checkNullOrEmpty: false),
                ]),
                initialValue:
                    invoiceProduct.value.discount.realValue > BigInt.from(0)
                        ? invoiceProduct.value.discount.rawValue
                        : null,
                onChanged: (text) {
                  invoiceProduct.value.discount = CopCurrency(text);
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.value.currentState!.validate()) {
                    Navigator.pop(context, invoiceProduct.value);
                  }
                },
                child: Text("ACEPTAR"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
