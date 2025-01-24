import 'package:ez_validator/ez_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyTextField extends StatefulWidget {
  final String hintText;
  final Function(String) onChanged;
  final TextCapitalization textCapitalization;

  final String? initialValue;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;

  const CurrencyTextField({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.textCapitalization = TextCapitalization.none,
    this.initialValue,
    this.keyboardType,
    this.inputFormatters,
    this.textInputAction,
  });

  @override
  State<CurrencyTextField> createState() => _CurrencyTextFieldState();
}

class _CurrencyTextFieldState extends State<CurrencyTextField> {
  NumberFormat formatter = NumberFormat.currency(locale: 'es_CO', name: 'COP');
  String formattedValue = '';

  onChanged(String value) {
    var intValue = value.isEmpty ? 0 : int.parse(value);

    // Update the currency visualization.
    setState(() {
      formattedValue = formatter.format(intValue);
    });

    // NOTE: This is very important! Here we are converting from pesos to cents.
    // This is to store correctly the money value.
    intValue *= 100;

    widget.onChanged(intValue.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(
            icon: Icon(Icons.attach_money_rounded),
            hintText: widget.hintText,
          ),
          onChanged: onChanged,
          textCapitalization: widget.textCapitalization,
          initialValue: widget.initialValue,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          validator: (value) =>
              EzValidator<String>().number().isInt().min(0).build()(value),
          textInputAction: widget.textInputAction,
        ),
        Text('Valor real: $formattedValue'),
      ],
    );
  }
}
