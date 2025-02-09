import 'package:flutter/material.dart';
import 'package:project_shelf/lib/cop_currency.dart';
import 'package:project_shelf/widgets/numpad.dart';

class CurrencyTextField extends StatefulWidget {
  final String labelText;
  final dynamic Function(String) onAccept;

  final TextEditingController controller;

  CurrencyTextField({
    super.key,
    required this.labelText,
    required this.onAccept,
  }) : controller = TextEditingController.fromValue(TextEditingValue(text: ""));

  @override
  State<CurrencyTextField> createState() => _CurrencyTextFieldState();
}

class _CurrencyTextFieldState extends State<CurrencyTextField> {
  String amount = "";

  onTap(BuildContext context) {
    showModalBottomSheet(
      enableDrag: false,
      context: context,
      builder: (BuildContext _) => StatefulBuilder(
        builder: (context, setState) => Column(
          children: [
            SizedBox(height: 16),
            Text(
              "Añadir Valor",
              style: TextStyle(
                color: Theme.of(context).hintColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(amount),
            Numpad(onValue: (value) {
              setState(() {
                amount = CopCurrency(value).formattedValue;
              });
            }),
            ElevatedButton(
              onPressed: () {
                widget.controller.text = amount;
                Navigator.pop(context);
              },
              child: Text("ACEPTAR"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  build(BuildContext context) {
    return Focus(
      // When the text field gains focus, open the modal.
      onFocusChange: (hasFocus) {
        if (hasFocus) {
          onTap(context);
        }
      },
      child: TextFormField(
        canRequestFocus: false,
        readOnly: true,
        controller: widget.controller,
        onTap: () => onTap(context),
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.labelText,
        ),
      ),
    );
  }
}
