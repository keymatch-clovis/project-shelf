import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Loader<T> extends StatelessWidget {
  final AsyncValue<T> asyncValue;
  final Widget Function(T) handler;

  const Loader({required this.asyncValue, required this.handler, super.key});

  @override
  Widget build(BuildContext context) {
    return switch (this.asyncValue) {
      AsyncData(:final value) => handler(value),
      AsyncError(:final error) => Text("Error: $error"),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}
