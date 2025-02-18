import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oxidized/oxidized.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool readOnly;
  final TextCapitalization textCapitalization;
  final bool autofocus;
  final bool isRequired;
  final TextInputAction textInputAction;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType keyboardType;

  final Option<Function(String)> onChanged;
  final Option<String> error;
  final Option<String> initialValue;
  final Option<Widget> icon;

  CustomTextField({
    super.key,
    required this.label,
    this.readOnly = false,
    this.autofocus = false,
    this.isRequired = false,
    this.inputFormatters = const [],
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.error = const Option.none(),
    Function(String)? onChanged,
    String? initialValue,
    Widget? icon,
  })  : this.onChanged = Option.from(onChanged),
        this.initialValue = Option.from(initialValue),
        this.icon = Option.from(icon);

  @override
  Widget build(BuildContext context) {
    Widget renderLabel() {
      final List<Widget> children = [];

      if (isRequired) {
        Color color = Theme.of(context).primaryColor;
        if (error.isSome()) {
          color = Colors.redAccent;
        }

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
          icon: icon.toNullable(),
          hintText: label,
          errorText: error.toNullable(),
        ),
        readOnly: readOnly,
        textCapitalization: textCapitalization,
        inputFormatters: inputFormatters,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        onChanged: onChanged.toNullable(),
        initialValue: initialValue.toNullable(),
      ),
    );
  }
}
