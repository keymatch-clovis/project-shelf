import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/components/dialog/print_invoice_dialog.dart';
import 'package:project_shelf/components/text_fields/custom_text_field.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/providers/customers.dart';

final customerProvider =
    FutureProvider.autoDispose.family<CustomerData, String>((ref, uuid) {
  return ref.watch(customersProvider.selectAsync((customers) {
    return customers.firstWhere((customer) => customer.uuid == uuid);
  }));
});

class InvoiceView extends ConsumerWidget {
  final InvoiceData _invoice;

  const InvoiceView(this._invoice, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customer = ref.watch(customerProvider(_invoice.customerUuid));

    if (customer.isLoading) {
      return Center(child: CircularProgressIndicator.adaptive());
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Factura: ${_invoice.number}"),
      ),
      body: Container(
        margin: const EdgeInsets.all(18),
        child: Column(
          children: [
            CustomTextField(
              label: "Número de Factura",
              readOnly: true,
              icon: FaIcon(FontAwesomeIcons.hashtag),
              initialValue: _invoice.number.toString(),
            ),
            CustomTextField(
              label: "Fecha",
              readOnly: true,
              initialValue: _invoice.date.toString(),
            ),
            CustomTextField(
              label: "Cliente",
              readOnly: true,
              initialValue: customer.value!.name,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: null,
            child: FaIcon(FontAwesomeIcons.print),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => PrintInvoiceDialog(_invoice),
            ),
          ),
        ],
      ),
    );
  }
}
