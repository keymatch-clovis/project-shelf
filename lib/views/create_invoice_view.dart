import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/components/dialog/create_invoice_product_dialog.dart';
import 'package:project_shelf/components/selectors/customer_selector.dart';
import 'package:project_shelf/components/selectors/product_selector.dart';
import 'package:project_shelf/components/text_fields/custom_text_field.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/providers/invoice/invoices.dart';

final consecutiveProvider = FutureProvider.autoDispose((ref) {
  return ref.watch(invoicesProvider.notifier).getConsecutive();
});

final invoiceProductsProvider =
    StateProvider.autoDispose<List<InvoiceProduct>>((ref) {
  return [];
});

final customerProvider = StateProvider.autoDispose<CustomerData?>((ref) {
  return null;
});

class CreateInvoiceView extends ConsumerWidget {
  final String? restorationId;

  const CreateInvoiceView({this.restorationId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customer = ref.watch(customerProvider);

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Crear Factura")),
      body: Container(
        margin: const EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                _ConsecutiveTextField(),
                CustomerSelector(
                  isRequired: true,
                  customerUuid: customer?.uuid,
                  onTap: (c) => ref.read(customerProvider.notifier).state = c,
                ),
                _InvoiceProductList(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            disabledElevation: 0,
            onPressed: () async {
              await ref.read(invoicesProvider.notifier).create(
                    data: InvoiceCompanion.insert(
                      number: await ref.read(consecutiveProvider.future),
                      customerUuid: customer!.uuid,
                    ),
                    invoiceProducts: ref.read(invoiceProductsProvider),
                  );

              context.go("/invoices");
            },
            child: FaIcon(FontAwesomeIcons.floppyDisk),
          ),
        ],
      ),
    );
  }
}

class _ConsecutiveTextField extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final consecutive = ref.watch(consecutiveProvider);

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        CustomTextField(
          readOnly: true,
          label: "Número de Factura",
          initialValue: consecutive.valueOrNull?.toString(),
          icon: FaIcon(FontAwesomeIcons.hashtag),
        ),
        if (consecutive.isLoading)
          Center(child: CircularProgressIndicator.adaptive()),
      ],
    );
  }
}

class _InvoiceProductList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoiceProducts = ref.watch(invoiceProductsProvider);

    void addInvoiceProduct(InvoiceProduct? invoiceProduct) {
      if (invoiceProduct == null) {
        return;
      }

      final index = invoiceProducts
          .indexWhere((ip) => ip.product.uuid == invoiceProduct.product.uuid);

      if (index >= 0) {
        ref.read(invoiceProductsProvider.notifier).update((invoiceProducts) {
          invoiceProducts[index] = invoiceProduct;
          return [...invoiceProducts];
        });
      } else {
        ref.read(invoiceProductsProvider.notifier).update((invoiceProducts) {
          return [...invoiceProducts..add(invoiceProduct)];
        });
      }
    }

    void removeInvoiceProduct(int index) {
      ref.read(invoiceProductsProvider.notifier).update((invoiceProducts) {
        invoiceProducts.removeAt(index);
        return [...invoiceProducts];
      });
    }

    Widget renderList() {
      if (invoiceProducts.isEmpty) {
        return Center(child: Text("Sin productos"));
      }
      return ListView.separated(
        padding: const EdgeInsets.all(0),
        itemCount: invoiceProducts.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        separatorBuilder: (_, __) => Divider(),
        itemBuilder: (context, index) => ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(invoiceProducts[index].product.name),
                  Text(invoiceProducts[index].price.formattedValue),
                  Text(invoiceProducts[index].discount.formattedValue),
                  Text(invoiceProducts[index].count.toString()),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () => removeInvoiceProduct(index),
                label: FaIcon(FontAwesomeIcons.trashCan),
              ),
            ],
          ),
          onTap: () async {
            final invoiceProduct = await showDialog(
              context: context,
              builder: (context) => CreateInvoiceProductDialog(
                invoiceProducts[index],
              ),
            );
            addInvoiceProduct(invoiceProduct);
          },
        ),
      );
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Productos"),
            ProductSelector(
              onTap: (product) async {
                final invoiceProduct = await showDialog(
                  context: context,
                  builder: (context) => CreateInvoiceProductDialog(
                    InvoiceProduct.fromProduct(product),
                  ),
                );
                addInvoiceProduct(invoiceProduct);
              },
            ),
          ],
        ),
        renderList(),
      ],
    );
  }
}
