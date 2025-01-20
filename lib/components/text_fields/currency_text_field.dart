import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CurrencyTextField extends StatefulWidget {
  final String hintText;
  final Function(String) onChanged;
  final TextCapitalization textCapitalization;

  final String? initialValue;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;

  const CurrencyTextField({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.textCapitalization = TextCapitalization.none,
    this.initialValue,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.textInputAction,
  });

  @override
  State<CurrencyTextField> createState() => _CurrencyTextFieldState();
}

class _CurrencyTextFieldState extends State<CurrencyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: widget.hintText),
      onChanged: widget.onChanged,
      textCapitalization: widget.textCapitalization,
      initialValue: widget.initialValue,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      validator: widget.validator,
      textInputAction: widget.textInputAction,
    );
  }
}
