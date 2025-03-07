import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/components/dialog/loading_dialog.dart';
import 'package:project_shelf/components/dropdowns/printers_dropdown.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/lib/error.dart';
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
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No has seleccionado una impresora."),
          ),
        );
        return;
      }

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => LoadingDialog("Imprimiendo..."),
      );

      final result = await ref.read(invoicesProvider.notifier).printInvoice(
            invoice: invoice,
            printerMac: printerMac,
          );

      // Close dialog.
      // ignore: use_build_context_synchronously
      Navigator.of(context, rootNavigator: true).pop();

      result.matchErr((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              switch (error) {
                PrintError.COULD_NOT_CONNECT_TO_PRINTER =>
                  "No se logró conectar con la impresora.",
                PrintError.NO_COMPANY_NAME =>
                  "Se necesita un nombre para la factura.",
                PrintError.NO_COMPANY_DOCUMENT =>
                  "Se necesita un documento para la factura.",
                PrintError.NO_COMPANY_EMAIL =>
                  "Se necesita un correo para la factura.",
                PrintError.NO_COMPANY_PHONE =>
                  "Se necesita un teléfono para la factura",
              },
            ),
          ),
        );
      });
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
