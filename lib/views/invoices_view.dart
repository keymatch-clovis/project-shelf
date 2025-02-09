import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InvoicesView extends ConsumerWidget {
  final String? restorationId;

  const InvoicesView({this.restorationId, super.key});

  Widget renderInvoiceList(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const FaIcon(
          FontAwesomeIcons.boxOpen,
          size: 48,
        ),
        const Text("Sin facturas"),
        const SizedBox(
          height: 32,
        ),
        ElevatedButton.icon(
          onPressed: () => context.go('/invoices/create'),
          icon: const FaIcon(
            FontAwesomeIcons.plus,
            size: 20,
          ),
          label: const Text("CREAR"),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      restorationId: restorationId,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Facturas'),
      ),
      body: SizedBox.expand(child: renderInvoiceList(context, ref)),
    );
  }
}
