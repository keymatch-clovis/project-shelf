import 'package:flutter/material.dart';
import 'package:project_shelf/lib/cop_currency.dart';
import 'package:project_shelf/widgets/numpad.dart';

class CurrencyTextField extends StatefulWidget {
  final String labelText;
  final dynamic Function(int) onAccept;

  final String? errorText;
  final Function(bool)? onFocusChange;

  const CurrencyTextField({
    super.key,
    required this.labelText,
    required this.onAccept,
    this.errorText,
    this.onFocusChange,
  });

  @override
  State<CurrencyTextField> createState() => _CurrencyTextFieldState();
}

class _CurrencyTextFieldState extends State<CurrencyTextField> {
  CopCurrency currency = CopCurrency(0);
  TextEditingController controller =
      TextEditingController.fromValue(TextEditingValue(text: ""));

  onTap(BuildContext context) async {
    widget.onFocusChange!(true);
    await showModalBottomSheet(
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
            Text(currency.formattedValue),
            Numpad(onValue: (value) {
              setState(() {
                currency = CopCurrency(value);
              });
            }),
            ElevatedButton(
              onPressed: () {
                widget.onAccept(currency.realValue);
                controller.text = currency.formattedValue;
                Navigator.pop(context);
              },
              child: Text("ACEPTAR"),
            ),
          ],
        ),
      ),
    );
    widget.onFocusChange!(false);
  }

  @override
  build(BuildContext context) {
    return Focus(
      onFocusChange: widget.onFocusChange,
      child: TextFormField(
        canRequestFocus: false,
        readOnly: true,
        controller: controller,
        onTap: () => onTap(context),
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.labelText,
          errorText: widget.errorText,
        ),
      ),
    );
  }
}
