import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/providers/product.dart';

class ProductView extends ConsumerWidget {
  final String id;

  const ProductView({required this.id, super.key});

  Widget renderProduct(BuildContext context, WidgetRef ref) {
    final asyncProduct = ref.watch(productProvider(id));
    return switch (asyncProduct) {
      AsyncData(:final value) => Text(value.id),
      _ => Center(child: const CircularProgressIndicator.adaptive())
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('aoeu')),
      body: SizedBox.expand(
        child: renderProduct(context, ref),
      ),
    );
  }
}
