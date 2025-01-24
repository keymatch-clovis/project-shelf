import 'package:ez_validator/ez_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:project_shelf/components/text_fields/currency_text_field.dart';
import 'package:project_shelf/components/text_fields/custom_text_field.dart';
import 'package:project_shelf/models/product.dart';
import 'package:project_shelf/utils/text_formatter.dart';

class CreateProductForm extends StatefulWidget {
  final String? restorationId;

  const CreateProductForm({this.restorationId, super.key});

  @override
  State<CreateProductForm> createState() => _CreateProductFormState();
}

// Define the widget.
class _CreateProductFormState extends State<CreateProductForm>
    with RestorationMixin {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  final RestorableString _name = RestorableString('');
  final RestorableString _value = RestorableString('');
  final RestorableString _stock = RestorableString('');
  final RestorableString _code = RestorableString('');

  submit() async {
    // This should always be true!
    if (context.mounted) {
      if (_formKey.currentState!.validate()) {
        await context.read<ProductModel>().add(
              name: _name.value,
              value: int.parse(_value.value),
              stock: int.parse(_stock.value),
              code: _code.value,
            );

        if (!mounted) return;
        context.go('/products');
      }
    }
  }

  @override
  String? get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    // All restorable properties MUST be register here with the mixin.
    registerForRestoration(_name, 'name');
    registerForRestoration(_value, 'value');
    registerForRestoration(_stock, 'stock');
    registerForRestoration(_code, 'code');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomTextField(
              hintText: 'Nombre',
              keyboardType: TextInputType.text,
              inputFormatters: [UpperCaseTextFormatter()],
              textCapitalization: TextCapitalization.characters,
              textInputAction: TextInputAction.next,
              initialValue: _name.value,
              onChanged: (value) => _name.value = value,
              validator: (value) =>
                  EzValidator<String>().required().build()(value),
            ),
            CurrencyTextField(
              hintText: 'Valor',
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              textInputAction: TextInputAction.next,
              initialValue: _value.value,
              onChanged: (value) => _value.value = value,
            ),
            CustomTextField(
              hintText: 'Cantidad',
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              initialValue: _stock.value,
              onChanged: (value) => _stock.value = value,
              validator: (value) =>
                  EzValidator<String>().number().isInt().min(0).build()(value),
            ),
            CustomTextField(
              hintText: 'Código',
              keyboardType: TextInputType.text,
              inputFormatters: [UpperCaseTextFormatter()],
              textCapitalization: TextCapitalization.characters,
              textInputAction: TextInputAction.next,
              initialValue: _code.value,
              onChanged: (value) => _code.value = value,
            ),
            ElevatedButton(
              onPressed: submit,
              child: const Text('CREAR PRODUCTO'),
            ),
          ],
        ),
      ),
    );
  }
}
