import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:project_shelf/widgets/currency_numpad.dart';

class NumberTextField extends HookWidget {
  final String labelText;
  final dynamic Function(String) onAccept;
  final String value;

  final TextEditingController controller;

  NumberTextField({
    super.key,
    required this.labelText,
    required this.onAccept,
    required this.value,
  }) : controller = TextEditingController.fromValue(TextEditingValue(text: ""));

  onTap(BuildContext context) async {
    await showModalBottomSheet(
      enableDrag: false,
      context: context,
      builder: (BuildContext context) => Column(
        children: [
          SizedBox(height: 16),
          Text(
            "Añadir Cantidad",
            style: TextStyle(
              color: Theme.of(context).hintColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          CurrencyNumpad(onAccept: onAccept),
        ],
      ),
    );
  }

  @override
  build(BuildContext context) {
    controller.value = TextEditingValue(text: value.toString());

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
        controller: controller,
        onTap: () => onTap(context),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: labelText,
        ),
      ),
    );
  }
}
