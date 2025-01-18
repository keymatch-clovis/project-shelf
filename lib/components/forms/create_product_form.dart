import 'package:ez_validator/ez_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_shelf/components/text_fields/custom_text_field.dart';
import 'package:project_shelf/models/product.dart';
import 'package:project_shelf/utils/text_formatter.dart';
import 'package:provider/provider.dart';

class CreateProductForm extends StatefulWidget {
  final int? id;
  final String? restorationId;

  const CreateProductForm({this.id, this.restorationId, super.key});

  @override
  State<CreateProductForm> createState() => _CreateProductFormState();
}

// Define the widget.
class _CreateProductFormState extends State<CreateProductForm>
    with RestorationMixin {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  _RestorableProduct product =
      _RestorableProduct({'name': '', 'value': '', 'stock': ''});

  @override
  String? get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(product, 'product');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Expanded(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              CustomTextField(
                hintText: 'Nombre',
                onChanged: (value) => product.value['name'] = value,
                initialValue: product.value['name'],
                keyboardType: TextInputType.text,
                inputFormatters: [UpperCaseTextFormatter()],
                textCapitalization: TextCapitalization.characters,
                validator: (value) => EzValidator<String>()
                    .required("Este campo es requerido.")
                    .build()(value),
                textInputAction: TextInputAction.next,
              ),
              CustomTextField(
                hintText: 'Valor',
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) => EzValidator<String>()
                    .required("Este campo es requerido.")
                    .number()
                    .isInt()
                    .build()(value),
                onChanged: (value) => product.value['value'] = value,
                textInputAction: TextInputAction.next,
              ),
              CustomTextField(
                hintText: 'Cantidad',
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) => EzValidator<String>()
                    .required("Este campo es requerido.")
                    .number()
                    .isInt()
                    .build()(value),
                onChanged: (value) => product.value['stock'] = value,
              ),
              CustomTextField(
                hintText: 'Código',
                keyboardType: TextInputType.text,
                inputFormatters: [UpperCaseTextFormatter()],
                textCapitalization: TextCapitalization.characters,
                textInputAction: TextInputAction.next,
                onChanged: (value) => product.value['code'] = value,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Creando producto...')));

                      context.read<ProductModel>().add(product.value);
                    }
                  },
                  child: const Text('CREAR PRODUCTO')),
            ],
          ),
        ),
      ),
    );
  }
}

class _RestorableProduct extends RestorableValue<Map<String, String?>> {
  final Map<String, String?> _defaultValue;

  _RestorableProduct(this._defaultValue);

  @override
  Map<String, String?> createDefaultValue() {
    return _defaultValue;
  }

  @override
  void didUpdateValue(Map<String, String?>? oldValue) {
    notifyListeners();
  }

  @override
  Map<String, String?> fromPrimitives(Object? data) {
    print("primitives $data");
    return {};
  }

  @override
  Object? toPrimitives() {
    return value;
  }
}
