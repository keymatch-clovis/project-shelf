import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oxidized/oxidized.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final bool readOnly;
  final TextCapitalization textCapitalization;

  final Option<Function(String)> onChanged;
  final Option<String> errorText;
  final Option<String> initialValue;
  final Option<TextInputType> keyboardType;
  final Option<List<TextInputFormatter>> inputFormatters;
  final Option<TextInputAction> textInputAction;
  final Option<Function(bool)> onFocusChange;
  final Option<Widget> icon;

  CustomTextField({
    super.key,
    required this.labelText,
    this.readOnly = false,
    this.textCapitalization = TextCapitalization.none,
    Function(String)? onChanged,
    String? errorText,
    String? initialValue,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    TextInputAction? textInputAction,
    Function(bool)? onFocusChange,
    Widget? icon,
  })  : this.onChanged = Option.from(onChanged),
        this.errorText = Option.from(errorText),
        this.initialValue = Option.from(initialValue),
        this.keyboardType = Option.from(keyboardType),
        this.inputFormatters = Option.from(inputFormatters),
        this.textInputAction = Option.from(textInputAction),
        this.onFocusChange = Option.from(onFocusChange),
        this.icon = Option.from(icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Focus(
        onFocusChange: onFocusChange.toNullable(),
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            icon: icon.toNullable(),
            labelText: labelText,
            hintText: labelText,
            errorText: errorText.toNullable(),
          ),
          readOnly: readOnly,
          onChanged: onChanged.toNullable(),
          textCapitalization: textCapitalization,
          initialValue: initialValue.toNullable(),
          keyboardType: keyboardType.toNullable(),
          inputFormatters: inputFormatters.toNullable(),
          textInputAction: textInputAction.toNullable(),
        ),
      ),
    );
  }
}
