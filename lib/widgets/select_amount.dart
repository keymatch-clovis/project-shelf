import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:math_expressions/math_expressions.dart';

class SelectAmount extends StatefulHookConsumerWidget {
  final Function(double, String) setSelectedAmount;

  const SelectAmount({required this.setSelectedAmount, super.key});

  @override
  SelectAmountState createState() => SelectAmountState();
}

class SelectAmountState extends ConsumerState<SelectAmount> {
  String amount = "";
  bool isControlPressed = false;

  final FocusNode _focusNode = FocusNode();
  late FocusAttachment _focusAttachment;

  @override
  void initState() {
    super.initState();

    _focusAttachment = _focusNode.attach(context, onKeyEvent: (node, event) {
      bool isKeyPressed = event.runtimeType == KeyDownEvent ||
          event.runtimeType == KeyRepeatEvent;

      // Control key management.
      if (event.logicalKey.keyLabel.toLowerCase().contains("control")) {
        if (isKeyPressed) {
          isControlPressed = true;
        } else {
          isControlPressed = false;
        }
      }

      // Handle going back.
      if (isKeyPressed && event.logicalKey.keyLabel == "Go Back" ||
          event.logicalKey == LogicalKeyboardKey.escape) {
        context.pop();
      }
      // Handle all of the other keys.
      else if (isKeyPressed && event.logicalKey == LogicalKeyboardKey.digit0) {
        _addToAmount("0");
      } else if (isKeyPressed &&
          event.logicalKey == LogicalKeyboardKey.digit1) {
        _addToAmount("1");
      } else if (isKeyPressed &&
          event.logicalKey == LogicalKeyboardKey.digit2) {
        _addToAmount("2");
      } else if (isKeyPressed &&
          event.logicalKey == LogicalKeyboardKey.digit3) {
        _addToAmount("3");
      } else if (isKeyPressed &&
          event.logicalKey == LogicalKeyboardKey.digit4) {
        _addToAmount("4");
      } else if (isKeyPressed &&
          event.logicalKey == LogicalKeyboardKey.digit5) {
        _addToAmount("5");
      } else if (isKeyPressed &&
          event.logicalKey == LogicalKeyboardKey.digit6) {
        _addToAmount("6");
      } else if (isKeyPressed &&
          event.logicalKey == LogicalKeyboardKey.digit7) {
        _addToAmount("7");
      } else if (isKeyPressed &&
          event.logicalKey == LogicalKeyboardKey.digit8) {
        _addToAmount("8");
      } else if (isKeyPressed &&
          event.logicalKey == LogicalKeyboardKey.digit9) {
        _addToAmount("9");
      } else if (isKeyPressed &&
          event.logicalKey == LogicalKeyboardKey.numpad0) {
        _addToAmount("0");
      } else if (isKeyPressed &&
          event.logicalKey == LogicalKeyboardKey.numpad1) {
        _addToAmount("1");
      } else if (isKeyPressed &&
          event.logicalKey == LogicalKeyboardKey.numpad2) {
        _addToAmount("2");
      } else if (isKeyPressed &&
          event.logicalKey == LogicalKeyboardKey.numpad3) {
        _addToAmount("3");
      } else if (isKeyPressed &&
          event.logicalKey == LogicalKeyboardKey.numpad4) {
        _addToAmount("4");
      } else if (isKeyPressed &&
          event.logicalKey == LogicalKeyboardKey.numpad5) {
        _addToAmount("5");
      } else if (isKeyPressed &&
          event.logicalKey == LogicalKeyboardKey.numpad6) {
        _addToAmount("6");
      } else if (isKeyPressed &&
          event.logicalKey == LogicalKeyboardKey.numpad7) {
        _addToAmount("7");
      } else if (isKeyPressed &&
          event.logicalKey == LogicalKeyboardKey.numpad8) {
        _addToAmount("8");
      } else if (isKeyPressed &&
          event.logicalKey == LogicalKeyboardKey.numpad9) {
        _addToAmount("9");
      } else if (isKeyPressed &&
          event.logicalKey == LogicalKeyboardKey.asterisk) {
        _addToAmount("×");
      } else if (isKeyPressed && event.logicalKey == LogicalKeyboardKey.slash) {
        _addToAmount("÷");
      } else if (isKeyPressed && event.logicalKey == LogicalKeyboardKey.add) {
        _addToAmount("+");
      } else if (isKeyPressed && event.logicalKey == LogicalKeyboardKey.minus) {
        _addToAmount("-");
      } else if (isKeyPressed &&
          event.logicalKey == LogicalKeyboardKey.period) {
        _addToAmount(".");
      } else if (isKeyPressed &&
          event.logicalKey == LogicalKeyboardKey.backspace) {
        _removeFromAmount();
      } else if (isKeyPressed &&
          event.logicalKey == LogicalKeyboardKey.delete) {
        _removeFromAmount();
      }
      return KeyEventResult.handled;
    });
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _focusAttachment.reparent();
    String amountConverted = amount;

    if (amountConverted == "") {
      amountConverted = "0";
    }

    return Column(
      children: [
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Builder(
                  builder: (context) {
                    final calculationString = (_includesOperations(
                                amount, false) &&
                            onlyOneOperationAndIsNegativeSign(amount) == false
                        ? operationsWithSpaces(amount)
                        : "");
                    print(calculationString);
                    return NumberPad(
                      addToAmount: _addToAmount,
                      removeFromAmount: _removeFromAmount,
                      removeAll: _removeAll,
                      canChange: _canChange,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  void _addToAmount(String input) {
    // TODO: Base case, it seems.
    if (amount.isEmpty && !_includesOperations(input, false)) {
      if (input == ".") {
        amount += "0$input";
      } else {
        amount += input;
      }
    }
    // TODO: What?
    else if (amount.isNotEmpty &&
            (!_includesOperations(amount.substring(amount.length - 1), true) &&
                _includesOperations(input, true)) ||
        !_includesOperations(input, true)) {
      amount += input;
    }
    // TODO: Hmm...
    else if (amount.isNotEmpty &&
        _includesOperations(amount.substring(amount.length - 1), false) &&
        input == ".") {
      amount += "0$input";
    }
    // TODO: Huh...
    else if (amount.isNotEmpty &&
        amount.substring(amount.length - 1) == "." &&
        _includesOperations(input, false)) {
      amount = amount.substring(0, amount.length - 1) + input;
    }
    // Replace last input operation with a new one.
    else if (amount.isNotEmpty &&
        _includesOperations(amount.substring(amount.length - 1), false) &&
        _includesOperations(input, false)) {
      amount = amount.substring(0, amount.length - 1) + input;
    }
    // TODO: Mmm...
    else if (amount.isNotEmpty && input == "-") {
      amount = "-";
    }

    _setSelectedAmount();
  }

  void _removeFromAmount() {
    if (amount.isNotEmpty) {
      amount = amount.substring(0, amount.length - 1);
    }
    _setSelectedAmount();
  }

  void _removeAll() {
    amount = "";

    _setSelectedAmount();
  }

  void _setSelectedAmount() {
    if (amount == "") {
      widget.setSelectedAmount(0, amount);
    } else if (_includesOperations(amount, false)) {
      widget.setSelectedAmount(_calculateResult(amount), amount);
    } else {
      widget.setSelectedAmount(double.tryParse(amount) ?? 0, amount);
    }
  }

  double _calculateResult(String input) {
    if (input == "") {
      return 0;
    }

    var changedInput = input;

    // Sanitize the input.
    if (_includesOperations(input.substring(input.length - 1), true)) {
      changedInput = input.substring(0, input.length - 1);
    }
    changedInput = changedInput.replaceAll("÷", "/");
    changedInput = changedInput.replaceAll("×", "*");

    double result = 0;
    try {
      ContextModel contextModel = ContextModel();
      Parser parser = Parser();
      Expression expression = parser.parse(changedInput);
      result = expression.evaluate(EvaluationType.REAL, contextModel);
    } catch (e) {
      print("error calculating result!");
    }

    if (onlyOneOperationAndIsNegativeSign(amount) && result == 0) {
      return -0;
    }
    return result;
  }

  bool _includesOperations(String input, bool includeDecimal) {
    if (onlyOneOperationAndIsNegativeSign(amount)) {
      return false;
    }

    List<String> operations = [
      "÷",
      "×",
      "-",
      "+",
      (includeDecimal ? "." : "+")
    ];

    for (String operation in operations) {
      if (input.contains(operation)) {
        return true;
      }
    }
    return false;
  }

  bool _canChange() {
    if (_includesOperations(amount, false)) {
      return true;
    } else if (amount.contains(".") && amount.split(".")[1].length >= 2) {
      return false;
    }
    return true;
  }
}

class NumberPad extends StatelessWidget {
  final Function(String input) addToAmount;
  final VoidCallback removeFromAmount;
  final VoidCallback removeAll;
  final bool Function() canChange;

  const NumberPad({
    required this.addToAmount,
    required this.removeFromAmount,
    required this.removeAll,
    required this.canChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget firstRow = Row(
      children: [
        TextButton(
          onPressed: () => addToAmount("1"),
          child: const FaIcon(FontAwesomeIcons.one),
        ),
        TextButton(
          onPressed: () => addToAmount("2"),
          child: const FaIcon(FontAwesomeIcons.two),
        ),
        TextButton(
          onPressed: () => addToAmount("3"),
          child: const FaIcon(FontAwesomeIcons.three),
        ),
      ],
    );
    Widget secondRow = Row(
      children: [
        TextButton(
          onPressed: () => addToAmount("4"),
          child: const FaIcon(FontAwesomeIcons.four),
        ),
        TextButton(
          onPressed: () => addToAmount("5"),
          child: const FaIcon(FontAwesomeIcons.five),
        ),
        TextButton(
          onPressed: () => addToAmount("6"),
          child: const FaIcon(FontAwesomeIcons.six),
        ),
      ],
    );
    Widget thirdRow = Row(
      children: [
        TextButton(
          onPressed: () => addToAmount("7"),
          child: const FaIcon(FontAwesomeIcons.seven),
        ),
        TextButton(
          onPressed: () => addToAmount("8"),
          child: const FaIcon(FontAwesomeIcons.eight),
        ),
        TextButton(
          onPressed: () => addToAmount("9"),
          child: const FaIcon(FontAwesomeIcons.nine),
        ),
      ],
    );
    Widget lastRow = Row(
      children: [
        TextButton(
          onPressed: () => addToAmount("."),
          child: const FaIcon(size: 6, FontAwesomeIcons.solidCircle),
        ),
        TextButton(
          onPressed: () => addToAmount("0"),
          child: const FaIcon(FontAwesomeIcons.zero),
        ),
        TextButton(
          onPressed: () => removeFromAmount(),
          onLongPress: () => removeAll(),
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
              onPressed: () => addToAmount("÷"),
              child: const FaIcon(FontAwesomeIcons.divide),
            ),
          ],
        ),
        Row(
          children: [
            TextButton(
              onPressed: () => addToAmount("×"),
              child: const FaIcon(FontAwesomeIcons.xmark),
            ),
          ],
        ),
        Row(
          children: [
            TextButton(
              onPressed: () => addToAmount("-"),
              child: const FaIcon(FontAwesomeIcons.minus),
            ),
          ],
        ),
        Row(
          children: [
            TextButton(
              onPressed: () => addToAmount("+"),
              child: const FaIcon(FontAwesomeIcons.plus),
            ),
          ],
        )
      ],
    );

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey,
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
        ElevatedButton(onPressed: () => {}, child: const Text("ACEPTAR"))
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

bool onlyOneOperationAndIsNegativeSign(String amount) {
  List<String> operations = [
    "÷",
    "×",
    "-",
    "+",
  ];

  if (amount.startsWith("-")) {
    int operationCount = operations.fold(
      0,
      (count, operation) => count + amount.split(operation).length - 1,
    );

    if (operationCount == 1 && amount.contains("-")) {
      return true;
    }
  }
  return false;
}

bool decimalCheck(String input) {
  var splitInputs = input.split(" ");
  for (var splitInput in splitInputs) {
    if (".".allMatches(splitInput).length > 1) {
      return false;
    }
  }
  return true;
}

String removeTrailingZeroes(String input) {
  if (!input.contains(".")) {
    return input;
  }

  int index = input.length - 1;
  while (input[index] == "0") {
    index--;
  }

  if (input[index] == ".") {
    index--;
  }

  return input.substring(0, index + 1);
}
