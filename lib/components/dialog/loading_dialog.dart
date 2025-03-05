import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  final String _message;

  const LoadingDialog(this._message, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      content: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator.adaptive(),
            Text(_message),
          ],
        ),
      ),
    );
  }
}
