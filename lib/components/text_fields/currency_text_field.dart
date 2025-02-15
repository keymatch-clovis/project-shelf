import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oxidized/oxidized.dart';
import 'package:project_shelf/lib/cop_currency.dart';
import 'package:project_shelf/widgets/numpad.dart';

class CurrencyTextField extends StatefulWidget {
  final String labelText;
  final bool readOnly;
  final bool showEditButton;
  final int initialValue;

  final Option<String> errorText;
  final Option<Function(bool)> onFocusChange;
  final Option<dynamic Function(int)> onAccept;

  CurrencyTextField({
    super.key,
    required this.labelText,
    this.initialValue = 0,
    this.readOnly = false,
    this.showEditButton = false,
    String? errorText,
    Function(bool)? onFocusChange,
    dynamic Function(int)? onAccept,
  })  : this.errorText = Option.from(errorText),
        this.onFocusChange = Option.from(onFocusChange),
        this.onAccept = Option.from(onAccept);

  @override
  State<CurrencyTextField> createState() => _CurrencyTextFieldState();
}

class _CurrencyTextFieldState extends State<CurrencyTextField> {
  late CopCurrency currency;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    currency = CopCurrency.fromCents(widget.initialValue);
    controller = TextEditingController.fromValue(
      TextEditingValue(text: currency.formattedValue),
    );
  }

  onTap(BuildContext context) async {
    if (widget.onFocusChange.isSome()) widget.onFocusChange.unwrap()(true);

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
                if (widget.onAccept.isSome()) {
                  widget.onAccept.unwrap()(currency.realValue);
                }

                controller.text = currency.formattedValue;
                Navigator.pop(context);
              },
              child: Text("ACEPTAR"),
            ),
          ],
        ),
      ),
    );
    if (widget.onFocusChange.isSome()) widget.onFocusChange.unwrap()(true);
  }

  @override
  build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Focus(
        onFocusChange: widget.onFocusChange.toNullable(),
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: widget.labelText,
            hintText: widget.labelText,
            errorText: widget.errorText.toNullable(),
            suffixIcon: widget.showEditButton
                ? IconButton(
                    onPressed: () => onTap(context),
                    icon: FaIcon(
                      FontAwesomeIcons.pen,
                    ),
                  )
                : null,
          ),
          readOnly: true,
          controller: controller,
          onTap: () {
            if (!widget.readOnly) {
              onTap(context);
            }
          },
        ),
      ),
    );
  }
}
