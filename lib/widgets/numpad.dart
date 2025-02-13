import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:math_expressions/math_expressions.dart';

const BUTTON_SIZE = 70.0;

class Numpad extends StatefulWidget {
  final bool canUseDecimals;
  final void Function(double) onValue;

  const Numpad({
    required this.onValue,
    this.canUseDecimals = true,
    super.key,
  });

  @override
  State<Numpad> createState() => _NumpadState();
}

class _NumpadState extends State<Numpad> {
  String _expression = "";
  double _value = 0;
  bool _hasSyntaxError = false;

  void _add(String value) {
    setState(() {
      _expression += value;
    });
    _update();
  }

  void _remove() {
    setState(() {
      _expression = _expression.isEmpty
          ? _expression
          : _expression.substring(0, _expression.length - 1);
    });
    _update();
  }

  void _removeAll() {
    setState(() {
      _expression = "";
    });
    _update();
  }

  void _update() {
    setState(() {
      try {
        _value = _evaluateExpression();
        _hasSyntaxError = false;
      } catch (e) {
        _value = 0;
        _hasSyntaxError = true;
      }
    });

    widget.onValue(_value);
  }

  double _evaluateExpression() {
    if (_expression == "") {
      return 0;
    }

    var changedExpression = _expression;
    changedExpression = changedExpression.replaceAll("÷", "/");
    changedExpression = changedExpression.replaceAll("×", "*");

    ContextModel contextModel = ContextModel();
    Parser parser = Parser();
    return parser
        .parse(changedExpression)
        .evaluate(EvaluationType.REAL, contextModel);
  }

  @override
  Widget build(BuildContext context) {
    Widget firstRow = Row(
      children: [
        NumpadButton(
          onPressed: () => _add("1"),
          icon: FontAwesomeIcons.one,
        ),
        NumpadButton(
          onPressed: () => _add("2"),
          icon: FontAwesomeIcons.two,
        ),
        NumpadButton(
          onPressed: () => _add("3"),
          icon: FontAwesomeIcons.three,
        ),
      ],
    );
    Widget secondRow = Row(
      children: [
        NumpadButton(
          onPressed: () => _add("4"),
          icon: FontAwesomeIcons.four,
        ),
        NumpadButton(
          onPressed: () => _add("5"),
          icon: FontAwesomeIcons.five,
        ),
        NumpadButton(
          onPressed: () => _add("6"),
          icon: FontAwesomeIcons.six,
        ),
      ],
    );
    Widget thirdRow = Row(
      children: [
        NumpadButton(
          onPressed: () => _add("7"),
          icon: FontAwesomeIcons.seven,
        ),
        NumpadButton(
          onPressed: () => _add("8"),
          icon: FontAwesomeIcons.eight,
        ),
        NumpadButton(
          onPressed: () => _add("9"),
          icon: FontAwesomeIcons.nine,
        ),
      ],
    );
    Widget lastRow = Row(
      children: [
        NumpadButton(
          onPressed: widget.canUseDecimals ? () => _add(".") : null,
          icon: FontAwesomeIcons.solidCircle,
          iconSize: BUTTON_SIZE / 6,
        ),
        NumpadButton(
          onPressed: () => _add("0"),
          icon: FontAwesomeIcons.zero,
        ),
        NumpadButton(
          onPressed: () => _remove(),
          onLongPress: () => _removeAll(),
          icon: FontAwesomeIcons.deleteLeft,
        ),
      ],
    );
    Widget functionColumn = Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            NumpadButton(
              onPressed: () => _add("÷"),
              icon: FontAwesomeIcons.divide,
            ),
          ],
        ),
        Row(
          children: [
            NumpadButton(
              onPressed: () => _add("×"),
              icon: FontAwesomeIcons.xmark,
            ),
          ],
        ),
        Row(
          children: [
            NumpadButton(
              onPressed: () => _add("-"),
              icon: FontAwesomeIcons.minus,
            ),
          ],
        ),
        Row(
          children: [
            NumpadButton(
              onPressed: () => _add("+"),
              icon: FontAwesomeIcons.plus,
            ),
          ],
        )
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          operationsWithSpaces(_expression),
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          maxLines: 1,
          style: TextStyle(
            color:
                _hasSyntaxError ? Colors.red : Theme.of(context).primaryColor,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).focusColor,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      thirdRow,
                      secondRow,
                      firstRow,
                      lastRow,
                    ],
                  ),
                  functionColumn,
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class NumpadButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final IconData icon;
  final double iconSize;

  const NumpadButton({
    required this.icon,
    this.onPressed,
    this.onLongPress,
    this.iconSize = BUTTON_SIZE / 2,
    super.key,
  });

  @override
  Widget build(BuildContext context) => TextButton(
        style: TextButton.styleFrom(minimumSize: Size.square(BUTTON_SIZE)),
        onPressed: onPressed,
        child: FaIcon(size: iconSize, icon),
      );
}

String operationsWithSpaces(String input) {
  return input
      .replaceAll("÷", " ÷ ")
      .replaceAll("×", " × ")
      .replaceAll("-", " - ")
      .replaceAll("+", " + ");
}
