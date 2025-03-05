import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:project_shelf/providers/invoice/invoices.dart';

class InvoicesView extends ConsumerWidget {
  final String? restorationId;

  const InvoicesView({this.restorationId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      restorationId: restorationId,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Facturas'),
      ),
      body: _InvoiceList(),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        FloatingActionButton(
          heroTag: null,
          onPressed: () => context.go('/invoices/create'),
          child: FaIcon(FontAwesomeIcons.plus),
        ),
      ],
    );
  }
}

class _InvoiceList extends ConsumerWidget {
  Widget renderList(List<InvoiceWithData> list) {
    if (list.isEmpty) {
      return Center(child: Text("Sin facturas"));
    }

    return ListView.separated(
      itemCount: list.length,
      separatorBuilder: (_, __) => Divider(),
      itemBuilder: (context, index) => ListTile(
        title: _ListItem(list[index]),
        onTap: () =>
            context.go("/invoices/invoice", extra: list[index].invoice),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoices = ref.watch(invoicesWithDataProvider);

    return switch (invoices) {
      AsyncData(:final value) => renderList(value),
      AsyncError(:final error) => Text("error: $error"),
      _ => const Center(child: CircularProgressIndicator.adaptive()),
    };
  }
}

class _ListItem extends StatelessWidget {
  final InvoiceWithData data;

  const _ListItem(this.data);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  "#${data.invoice.number.toString()}",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Expanded(
                child: Text(
                  textAlign: TextAlign.right,
                  Jiffy.parseFromDateTime(data.invoice.date).fromNow(),
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
              ),
            ],
          ),
          Text(
            data.customer.name,
            overflow: TextOverflow.fade,
          )
        ],
      ),
    );
  }
}
