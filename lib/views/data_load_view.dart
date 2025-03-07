import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/components/dialog/loading_dialog.dart';
import 'package:project_shelf/lib/error.dart';
import 'package:project_shelf/providers/customers.dart';
import 'package:project_shelf/providers/invoice/invoices.dart';
import 'package:project_shelf/providers/product/products.dart';

class DataLoadView extends ConsumerWidget {
  const DataLoadView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void uploadProducts() async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => LoadingDialog("Cargando productos..."),
      );

      final result = await ref.read(productsProvider.notifier).uploadProducts();

      // Close dialog.
      // ignore: use_build_context_synchronously
      Navigator.of(context, rootNavigator: true).pop();

      result.matchOk((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Productos cargados"),
          ),
        );
      });
      result.matchErr((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              switch (error) {
                FileLoadError.FILE_NOT_SELECTED =>
                  "No has seleccionado un archivo.",
                FileLoadError.BROKEN_FILE => "No se pudo cargar el archivo.",
                FileLoadError.INCORRECT_FILE_FORMAT =>
                  "El archivo tiene un formato incorrecto.",
              },
            ),
          ),
        );
      });
    }

    uploadCustomers() async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => LoadingDialog("Cargando clientes..."),
      );

      final result =
          await ref.read(customersProvider.notifier).uploadCustomers();

      // Close dialog.
      // ignore: use_build_context_synchronously
      Navigator.of(context, rootNavigator: true).pop();

      result.matchOk((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Clientes cargados"),
          ),
        );
      });
      result.matchErr((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              switch (error) {
                FileLoadError.FILE_NOT_SELECTED =>
                  "No has seleccionado un archivo.",
                FileLoadError.BROKEN_FILE => "No se pudo cargar el archivo.",
                FileLoadError.INCORRECT_FILE_FORMAT =>
                  "El archivo tiene un formato incorrecto.",
              },
            ),
          ),
        );
      });
    }

    uploadInvoices() async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => LoadingDialog("Cargando facturas..."),
      );

      final result = await ref.read(invoicesProvider.notifier).uploadInvoices();

      // Close dialog.
      // ignore: use_build_context_synchronously
      Navigator.of(context, rootNavigator: true).pop();

      result.matchOk((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Facturas cargadas"),
          ),
        );
      });
      result.matchErr((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              switch (error) {
                FileLoadError.FILE_NOT_SELECTED =>
                  "No has seleccionado un archivo.",
                FileLoadError.BROKEN_FILE => "No se pudo cargar el archivo.",
                FileLoadError.INCORRECT_FILE_FORMAT =>
                  "El archivo tiene un formato incorrecto.",
              },
            ),
          ),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Cargar Datos"),
      ),
      body: Container(
          margin: const EdgeInsets.all(18),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: [
              _Button(
                title: "Cargar Productos",
                icon: FontAwesomeIcons.boxesStacked,
                onTap: uploadProducts,
              ),
              _Button(
                title: "Cargar Facturas",
                icon: FontAwesomeIcons.receipt,
                onTap: uploadInvoices,
              ),
              _Button(
                title: "Cargar Clientes",
                icon: FontAwesomeIcons.peopleGroup,
                onTap: uploadCustomers,
              ),
            ],
          )),
    );
  }
}

class _Button extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;

  const _Button({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        title: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(size: 32, icon),
              const SizedBox(height: 8),
              Text(title),
            ],
          ),
        ),
        onTap: () => onTap(),
      ),
    );
  }
}
