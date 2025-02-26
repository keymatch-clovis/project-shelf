import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/components/text_fields/custom_text_field.dart';
import 'package:project_shelf/util/text_formatter.dart';


class ProductView extends ConsumerWidget {
  final String id;

  const ProductView({required this.id, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final product = ref.watch(productProvider(id));
    // final state = ref.watch(editFormProvider(id));

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("aoeu")),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Text("aoeuuc"),
      ),
    );
  }
}
