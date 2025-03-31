import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String _error;

  const ErrorDialog(this._error, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_error),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("ACEPTAR"),
            ),
          ],
        ),
      ),
    );
  }
}
