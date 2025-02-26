import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomTextField extends StatelessWidget {
  final void Function(String) onChanged;
  final String label;
  final bool readOnly;
  final TextCapitalization textCapitalization;
  final bool autofocus;
  final bool isRequired;
  final TextInputAction textInputAction;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType keyboardType;

  final String? initialValue;
  final FormFieldValidator<String>? validator;
  final Widget? icon;

  const CustomTextField({
    super.key,
    required this.onChanged,
    required this.label,
    this.readOnly = false,
    this.autofocus = false,
    this.isRequired = false,
    this.inputFormatters = const [],
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.initialValue,
    this.validator,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    Widget renderLabel() {
      final List<Widget> children = [];

      if (isRequired) {
        Color color = Theme.of(context).primaryColor;

        children.add(
          FaIcon(
            size: 14,
            color: color,
            FontAwesomeIcons.asterisk,
          ),
        );
        children.add(SizedBox(width: 4));
      }

      children.add(Text(label));

      return Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        autofocus: autofocus,
        decoration: InputDecoration(
          label: renderLabel(),
          border: OutlineInputBorder(),
          icon: icon,
          hintText: label,
        ),
        readOnly: readOnly,
        textCapitalization: textCapitalization,
        inputFormatters: inputFormatters,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        initialValue: initialValue,
        onChanged: onChanged,
      ),
    );
  }
}
