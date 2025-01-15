import 'package:ez_validator/ez_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_shelf/utils/text_formatter.dart';

// Define the widget.
class CreateProductForm extends StatefulWidget {
  const CreateProductForm({super.key});

  @override
  CreateProductFormState createState() {
    return CreateProductFormState();
  }
}

// Define a corresponding state class for the widget.
// This class holds the data related to the form.
class CreateProductFormState extends State<CreateProductForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final valueController = TextEditingController();
  final codeController = TextEditingController();
  final stockController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formKey,
        child: Expanded(
            child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                keyboardType: TextInputType.text,
                inputFormatters: [UpperCaseTextFormatter()],
                textCapitalization: TextCapitalization.characters,
                validator: (value) => EzValidator<String>()
                    .required("Este campo es requerido.")
                    .build()(value),
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                controller: valueController,
                decoration: const InputDecoration(labelText: 'Valor'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) => EzValidator<String>()
                    .required("Este campo es requerido.")
                    .number()
                    .isInt()
                    .build()(value),
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                controller: codeController,
                decoration: const InputDecoration(labelText: 'Código'),
                keyboardType: TextInputType.text,
                inputFormatters: [UpperCaseTextFormatter()],
                textCapitalization: TextCapitalization.characters,
                validator: (value) => EzValidator<String>()
                    .required("Este campo es requerido.")
                    .build()(value),
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                controller: stockController,
                decoration: const InputDecoration(labelText: 'Cantidad'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) => EzValidator<String>()
                    .required("Este campo es requerido.")
                    .number()
                    .isInt()
                    .build()(value),
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Creando producto...')));

                      // var database = await getDatabase();
                      // await insertProduct(
                      //     database,
                      //     CreateProduct(
                      //       name: nameController.text,
                      //       value: int.parse(valueController.text),
                      //       code: codeController.text,
                      //       stock: int.parse(stockController.text),
                      //     ));
                    }
                  },
                  child: const Text('CREAR PRODUCTO')),
            ],
          ),
        )));
  }
}
