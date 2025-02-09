import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/components/dialog/search_product_dialog.dart';

class CreateInvoiceView extends ConsumerWidget {
  final String? restorationId;

  const CreateInvoiceView({this.restorationId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RestorationScope(
      restorationId: restorationId,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Crear Factura'),
          ),
          //body: SearchProductDialog(),
          body: Column(
            children: [
              SearchProductDialog(),
              Spacer(),
              ElevatedButton(
                onPressed: () => {},
                child: const Text("CREAR FACTURA"),
              ),
            ],
          )),
    );
  }
}
