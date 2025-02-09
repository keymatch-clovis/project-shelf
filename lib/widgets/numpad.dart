import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:math_expressions/math_expressions.dart';

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
        TextButton(
          onPressed: () => _add("1"),
          child: const FaIcon(FontAwesomeIcons.one),
        ),
        TextButton(
          onPressed: () => _add("2"),
          child: const FaIcon(FontAwesomeIcons.two),
        ),
        TextButton(
          onPressed: () => _add("3"),
          child: const FaIcon(FontAwesomeIcons.three),
        ),
      ],
    );
    Widget secondRow = Row(
      children: [
        TextButton(
          onPressed: () => _add("4"),
          child: const FaIcon(FontAwesomeIcons.four),
        ),
        TextButton(
          onPressed: () => _add("5"),
          child: const FaIcon(FontAwesomeIcons.five),
        ),
        TextButton(
          onPressed: () => _add("6"),
          child: const FaIcon(FontAwesomeIcons.six),
        ),
      ],
    );
    Widget thirdRow = Row(
      children: [
        TextButton(
          onPressed: () => _add("7"),
          child: const FaIcon(FontAwesomeIcons.seven),
        ),
        TextButton(
          onPressed: () => _add("8"),
          child: const FaIcon(FontAwesomeIcons.eight),
        ),
        TextButton(
          onPressed: () => _add("9"),
          child: const FaIcon(FontAwesomeIcons.nine),
        ),
      ],
    );
    Widget lastRow = Row(
      children: [
        TextButton(
          onPressed: widget.canUseDecimals ? () => _add(".") : null,
          child: const FaIcon(size: 6, FontAwesomeIcons.solidCircle),
        ),
        TextButton(
          onPressed: () => _add("0"),
          child: const FaIcon(FontAwesomeIcons.zero),
        ),
        TextButton(
          onPressed: () => _remove(),
          onLongPress: () => _removeAll(),
          child: const FaIcon(FontAwesomeIcons.deleteLeft),
        ),
      ],
    );
    Widget functionColumn = Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            TextButton(
              onPressed: () => _add("÷"),
              child: const FaIcon(FontAwesomeIcons.divide),
            ),
          ],
        ),
        Row(
          children: [
            TextButton(
              onPressed: () => _add("×"),
              child: const FaIcon(FontAwesomeIcons.xmark),
            ),
          ],
        ),
        Row(
          children: [
            TextButton(
              onPressed: () => _add("-"),
              child: const FaIcon(FontAwesomeIcons.minus),
            ),
          ],
        ),
        Row(
          children: [
            TextButton(
              onPressed: () => _add("+"),
              child: const FaIcon(FontAwesomeIcons.plus),
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

String operationsWithSpaces(String input) {
  return input
      .replaceAll("÷", " ÷ ")
      .replaceAll("×", " × ")
      .replaceAll("-", " - ")
      .replaceAll("+", " + ");
}
