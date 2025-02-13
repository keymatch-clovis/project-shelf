import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final Function(String) onChanged;

  final String? errorText;
  final TextCapitalization textCapitalization;
  final String? initialValue;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final Function(bool)? onFocusChange;
  final bool? readOnly;
  final Widget? icon;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.onChanged,
    this.errorText,
    this.textCapitalization = TextCapitalization.none,
    this.initialValue,
    this.keyboardType,
    this.inputFormatters,
    this.textInputAction,
    this.onFocusChange,
    this.readOnly = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: onFocusChange,
      child: TextFormField(
        decoration: InputDecoration(
          icon: icon,
          labelText: labelText,
          hintText: labelText,
          errorText: errorText,
        ),
        readOnly: readOnly ?? false,
        onChanged: onChanged,
        textCapitalization: textCapitalization,
        initialValue: initialValue,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        textInputAction: textInputAction,
      ),
    );
  }
}
