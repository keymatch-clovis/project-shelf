import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/components/dialog/print_invoice_dialog.dart';
import 'package:project_shelf/components/text_fields/custom_text_field.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/lib/cop_currency.dart';
import 'package:project_shelf/providers/customers.dart';
import 'package:project_shelf/providers/invoice/invoices.dart';

final customerProvider =
    FutureProvider.autoDispose.family<CustomerData, String>((ref, uuid) {
  return ref.watch(customersProvider.selectAsync((customers) {
    return customers.firstWhere((data) => data.customer.uuid == uuid);
  })).then((data) => data.customer);
});

final invoiceProductsProvider =
    FutureProvider.autoDispose.family<InvoiceWithProducts, String>((ref, uuid) {
  return ref
      .watch(invoicesProvider.notifier)
      .findByUuid(uuid)
      .then((data) => data.unwrap());
});

class InvoiceView extends ConsumerWidget {
  final InvoiceData _invoice;

  const InvoiceView(this._invoice, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customer = ref.watch(customerProvider(_invoice.customerUuid));
    final invoiceProducts = ref.watch(invoiceProductsProvider(_invoice.uuid));

    bool hasValue() => customer.hasValue && invoiceProducts.hasValue;

    if (!hasValue()) {
      return Center(child: CircularProgressIndicator.adaptive());
    }

    BigInt totalInvoice = BigInt.from(0);
    for (final product in invoiceProducts.value!.products) {
      totalInvoice += (product.productInvoice.price *
              BigInt.from(product.productInvoice.count)) -
          product.productInvoice.discount;
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
            Text("Productos"),
            Expanded(
              child: _InvoiceProductsList(_invoice),
            ),
            Text(
                "Total: ${CopCurrency.fromCents(totalInvoice).formattedValue}"),
          ],
        ),
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        FloatingActionButton(
          heroTag: null,
          child: FaIcon(FontAwesomeIcons.print),
          onPressed: () => showDialog(
            context: context,
            builder: (context) => PrintInvoiceDialog(_invoice),
          ),
        ),
      ],
    );
  }
}

class _InvoiceProductsList extends ConsumerWidget {
  final InvoiceData invoice;

  const _InvoiceProductsList(this.invoice);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoiceProducts =
        ref.watch(invoiceProductsProvider(this.invoice.uuid));

    if (!invoiceProducts.hasValue) {
      return Center(child: CircularProgressIndicator.adaptive());
    }

    Widget renderList(List<ProductInvoiceWithProduct> products) {
      return ListView.separated(
        itemCount: products.length,
        separatorBuilder: (_, __) => Divider(),
        itemBuilder: (context, index) => ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(products[index].product.name),
                    Text(CopCurrency.fromCents(
                            products[index].productInvoice.price)
                        .formattedValue),
                    Text(CopCurrency.fromCents(
                            products[index].productInvoice.discount)
                        .formattedValue),
                    Text(products[index].productInvoice.count.toString()),
                    Text(CopCurrency.fromCents(
                            (products[index].productInvoice.price *
                                    BigInt.from(
                                        products[index].productInvoice.count)) -
                                products[index].productInvoice.discount)
                        .formattedValue),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return renderList(invoiceProducts.value!.products);
  }
}
