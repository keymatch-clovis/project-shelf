import 'package:flutter/material.dart';
import 'package:project_shelf/widgets/numpad.dart';

class NumberTextField extends StatefulWidget {
  final String labelText;
  final dynamic Function(int) onAccept;

  final String? errorText;
  final Function(bool)? onFocusChange;

  const NumberTextField({
    super.key,
    required this.labelText,
    required this.onAccept,
    this.errorText,
    this.onFocusChange,
  });

  @override
  State<NumberTextField> createState() => _NumberTextFieldState();
}

class _NumberTextFieldState extends State<NumberTextField> {
  int amount = 0;
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
            Text(amount.toString()),
            Numpad(
              canUseDecimals: false,
              onValue: (value) {
                setState(() {
                  amount = value.round();
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                widget.onAccept(amount);
                controller.text = amount.toString();
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
