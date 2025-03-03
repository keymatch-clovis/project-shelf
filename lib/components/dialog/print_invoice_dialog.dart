import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/components/dropdowns/printers_dropdown.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/providers/invoice/invoices.dart';
import 'package:project_shelf/providers/preferences.dart';

class PrintInvoiceDialog extends ConsumerWidget {
  final InvoiceData invoice;

  const PrintInvoiceDialog(this.invoice, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void printInvoice() async {
      final printerMac =
          await ref.read(preferencesProvider.future).then((preferences) {
        return preferences[PreferenceName.DEFAULT_PRINTER_MAC];
      });

      if (printerMac == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No has seleccionado una impresora."),
          ),
        );
        return;
      }

      ref.read(invoicesProvider.notifier).printInvoice(
            invoice: invoice,
            printerMac: printerMac,
          );
    }

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Imprimir"),
            PrintersDropdown(),
            ElevatedButton(
              onPressed: printInvoice,
              child: Text("Imprimir"),
            ),
          ],
        ),
      ),
    );
  }
}
