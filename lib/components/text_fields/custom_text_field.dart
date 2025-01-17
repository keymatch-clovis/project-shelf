import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final Function(String) onChanged;
  final TextCapitalization textCapitalization;

  final String? initialValue;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;

  const CustomTextField({
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
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          decoration: InputDecoration(hintText: widget.hintText),
          onChanged: widget.onChanged,
          textCapitalization: widget.textCapitalization,
          initialValue: widget.initialValue,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          validator: widget.validator,
          textInputAction: widget.textInputAction,
        ));
  }
}
