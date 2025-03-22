import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/components/dialog/accept_dialog.dart';
import 'package:project_shelf/components/dialog/loading_dialog.dart';
import 'package:project_shelf/components/text_fields/custom_text_field.dart';
import 'package:project_shelf/database/database.dart';
import 'package:project_shelf/lib/constants.dart';
import 'package:project_shelf/lib/cop_currency.dart';
import 'package:project_shelf/providers/invoice/invoices.dart';
import 'package:project_shelf/providers/product/product_mementos.dart';
import 'package:project_shelf/providers/product/products.dart';
import 'package:project_shelf/util/text_formatter.dart';

class ProductView extends ConsumerWidget {
  final ProductData product;
  const ProductView(this.product, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider.select((asyncValue) {
      return asyncValue.whenData((products) {
        return products.firstWhere((p) => p.uuid == product.uuid);
      });
    }));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(product.name, style: TEXT_GREEN_800.merge(FONT_BOLD)),
      ),
      body: switch (products) {
        AsyncData(:final value) => DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: const TabBar(tabs: [
                    Tab(icon: FaIcon(FontAwesomeIcons.info)),
                    Tab(icon: FaIcon(FontAwesomeIcons.receipt)),
                    Tab(icon: FaIcon(FontAwesomeIcons.clockRotateLeft)),
                  ]),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _ProductInfo(value),
                      _InvoicesList(value),
                      _MementosList(value),
                    ],
                  ),
                ),
              ],
            ),
          ),
        AsyncError(:final error) => Text("error: $error"),
        _ => const Center(child: CircularProgressIndicator.adaptive()),
      },
    );
  }
}

class _ProductInfo extends ConsumerStatefulWidget {
  final ProductData product;

  const _ProductInfo(this.product);

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends ConsumerState<_ProductInfo> {
  late Products provider;
  late ProductData editedProduct;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    editedProduct = widget.product.copyWith();
    provider = ref.read(productsProvider.notifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final canEdit = widget.product != editedProduct;

    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.white,
            padding: EI_16,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Información del Producto",
                    textAlign: TextAlign.start,
                    style: TEXT_STONE_800.merge(FONT_BOLD).merge(TEXT_SM),
                  ),
                  CustomTextField(
                    isRequired: true,
                    label: "Nombre del Cliente",
                    inputFormatters: [UpperCaseTextFormatter()],
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.characters,
                    keyboardType: TextInputType.name,
                    onChanged: (text) {
                      setState(() {
                        editedProduct = editedProduct.copyWith(name: text);
                      });
                    },
                    initialValue: widget.product.name,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  CustomTextField(
                    label: "Precio por Defecto",
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    onChanged: (text) {
                      setState(() {
                        editedProduct = editedProduct.copyWith(
                          price: text.trim().isEmpty
                              ? null
                              : CopCurrency(text).realValue,
                        );
                      });
                    },
                    initialValue:
                        CopCurrency.fromCents(widget.product.price).rawValue,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.numeric(checkNullOrEmpty: false),
                      FormBuilderValidators.min(0, checkNullOrEmpty: false),
                    ]),
                  ),
                  CustomTextField(
                    label: "Cantidad en Inventario",
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    onChanged: (text) {
                      setState(() {
                        editedProduct = editedProduct.copyWith(
                          stock: text.trim().isEmpty ? null : int.parse(text),
                        );
                      });
                    },
                    initialValue: widget.product.stock.toString(),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.numeric(checkNullOrEmpty: false),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: H_72,
          decoration: BoxDecoration(
            border: BORDER_T,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Padding(
            padding: P_8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FilledButton.tonalIcon(
                  label: FaIcon(FontAwesomeIcons.solidTrashCan),
                  style: CUSTOM_FILLED_BUTTON,
                  onPressed: () => _delete(context),
                ),
                const SizedBox(width: 12),
                FilledButton.icon(
                  label: FaIcon(FontAwesomeIcons.solidFloppyDisk),
                  style: CUSTOM_FILLED_BUTTON,
                  onPressed: canEdit ? () => _edit(context) : null,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _delete(BuildContext context) async {
    final result = await showDialog(
      context: context,
      useRootNavigator: true,
      builder: (_) => AcceptDialog("¿Estás seguro?"),
    );

    if (result != null && result) {
      final result = await withLoading(
          // ignore: use_build_context_synchronously
          context: context,
          message: "Eliminando...", () async {
        return await ref
            .read(productsProvider.notifier)
            .delete(widget.product.uuid);
      });

      result.match(
        (_) => context.go("/products"),
        (err) => err.showSnackBar(context),
      );
    }
  }

  void _edit(BuildContext context) async {
    await ref.read(productsProvider.notifier).replace(editedProduct);
  }
}

class _InvoicesList extends ConsumerWidget {
  final ProductData product;
  const _InvoicesList(this.product);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoices = ref.watch(invoicesProvider.select((asyncData) {
      return asyncData.whenData((invoices) {
        return invoices.where((i) => i.pr == product.)
      })
  }));

    return switch (mementos) {
      AsyncData(:final value) => renderList(context, value),
      AsyncError(:final error) => Text("error: $error"),
      _ => const Center(child: CircularProgressIndicator.adaptive()),
    };
  }

  Widget renderList(BuildContext context, ProductMementosState state) {
    if (state.mementos.isEmpty) {
      return Center(child: Text("Sin cambios", style: TEXT_STONE_600));
    }

    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.white,
            padding: EI_16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cambios del Producto",
                  textAlign: TextAlign.start,
                  style: TEXT_STONE_800.merge(FONT_BOLD).merge(TEXT_SM),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: BORDER,
                      borderRadius: ROUNDED_MD,
                    ),
                    child: ListView.separated(
                      itemCount: state.mementos.length,
                      separatorBuilder: (_, __) => Divider(height: 0),
                      itemBuilder: (context, index) => ListTile(
                        tileColor: Colors.white,
                        title: Column(
                          children: [
                            Text(state.mementos[index].date.toString()),
                            Text(state.mementos[index].data),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: H_72,
          decoration: BoxDecoration(
            border: BORDER_T,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Padding(
            padding: P_8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [],
            ),
          ),
        ),
      ],
    );
  }
}

class _MementosList extends ConsumerWidget {
  final ProductData product;
  const _MementosList(this.product);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mementos = ref.watch(productMementosProvider(product.uuid));

    return switch (mementos) {
      AsyncData(:final value) => renderList(context, value),
      AsyncError(:final error) => Text("error: $error"),
      _ => const Center(child: CircularProgressIndicator.adaptive()),
    };
  }

  Widget renderList(BuildContext context, ProductMementosState state) {
    if (state.mementos.isEmpty) {
      return Center(child: Text("Sin cambios", style: TEXT_STONE_600));
    }

    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.white,
            padding: EI_16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cambios del Producto",
                  textAlign: TextAlign.start,
                  style: TEXT_STONE_800.merge(FONT_BOLD).merge(TEXT_SM),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: BORDER,
                      borderRadius: ROUNDED_MD,
                    ),
                    child: ListView.separated(
                      itemCount: state.mementos.length,
                      separatorBuilder: (_, __) => Divider(height: 0),
                      itemBuilder: (context, index) => ListTile(
                        tileColor: Colors.white,
                        title: Column(
                          children: [
                            Text(state.mementos[index].date.toString()),
                            Text(state.mementos[index].data),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: H_72,
          decoration: BoxDecoration(
            border: BORDER_T,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Padding(
            padding: P_8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [],
            ),
          ),
        ),
      ],
    );
  }
}
