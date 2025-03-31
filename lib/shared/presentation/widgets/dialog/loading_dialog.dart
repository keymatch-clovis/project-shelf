import 'dart:async';

import 'package:flutter/material.dart';
import 'package:oxidized/oxidized.dart';

FutureOr<Result<T, E>> withLoading<T, E extends Object>(
  Future<Result<T, E>> Function() callback, {
  required BuildContext context,
  required String message,
}) async {
  showDialog(
    context: context,
    useRootNavigator: true,
    barrierDismissible: false,
    builder: (_) => LoadingDialog(message),
  );

  final result = await callback();

  // Close dialog.
  if (context.mounted) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  return result;
}

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
