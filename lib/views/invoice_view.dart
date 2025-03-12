import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/components/dialog/print_invoice_dialog.dart';
import 'package:project_shelf/components/pill.dart';
import 'package:project_shelf/components/text_fields/custom_text_field.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/lib/constants.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "#${_invoice.number}",
          style: TEXT_GREEN_800.merge(FONT_BOLD),
        ),
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
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Productos",
                  style: TEXT_STONE_600.merge(TEXT_XS),
                ),
              ],
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: STONE_400),
                  borderRadius: ROUNDED_MD,
                ),
                child: _InvoiceProductsList(_invoice),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: H8),
                    Text(
                      CopCurrency.fromCents(totalInvoice).formattedValue,
                      style: TEXT_2XL.merge(FONT_BOLD).merge(LEADING_XS),
                    ),
                    Text("Total", style: TEXT_XS.merge(TEXT_STONE_600)),
                  ],
                ),
              ],
            ),
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
    final asyncData = ref.watch(invoiceProductsProvider(this.invoice.uuid));

    return switch (asyncData) {
      AsyncData(:final value) => renderList(value.products),
      AsyncError(:final error) => Text("error: $error"),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }

  Widget renderList(List<ProductInvoiceWithProduct> products) {
    if (products.isEmpty) {
      return Center(child: Text("Sin productos", style: TEXT_STONE_600));
    }

    return ListView.separated(
      itemCount: products.length,
      separatorBuilder: (_, __) => Divider(height: 0),
      itemBuilder: (context, index) => _ListItem(products[index]),
    );
  }
}

class _ListItem extends StatelessWidget {
  final ProductInvoiceWithProduct item;
  const _ListItem(this.item);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: PX_8,
      title: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: TEXT_SM.merge(TEXT_STONE_800),
                ),
                Text(
                  CopCurrency.fromCents(item.productInvoice.price)
                      .formattedValue,
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Pill(
                iconData: FontAwesomeIcons.xmark,
                color: STONE_200,
                textColor: STONE_600,
                text: item.productInvoice.count > 9999
                    ? "9999"
                    : item.productInvoice.count.toString(),
              ),
              Text(
                CopCurrency.fromCents((item.productInvoice.price *
                            BigInt.from(item.productInvoice.count)) -
                        item.productInvoice.discount)
                    .formattedValue,
                style: TEXT_LG.merge(FONT_BOLD),
              ),
              ...renderDiscount(),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> renderDiscount() {
    if (item.productInvoice.discount.toInt() > 0) {
      return [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "-${CopCurrency.fromCents(item.productInvoice.discount).formattedValue}",
              style: FONT_BOLD.merge(TEXT_RED_800),
            ),
          ],
        ),
      ];
    }
    return [];
  }
}
