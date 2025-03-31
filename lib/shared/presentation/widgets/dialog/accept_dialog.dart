import 'package:flutter/material.dart';

class AcceptDialog extends StatelessWidget {
  final String message;
  final String? buttonMessage;

  const AcceptDialog(
    this.message, {
    super.key,
    this.buttonMessage,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      content: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(buttonMessage ?? "Aceptar"),
            ),
          ],
        ),
      ),
    );
  }
}
