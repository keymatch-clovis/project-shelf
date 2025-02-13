import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_shelf/components/dialog/search_product_anchor.dart';
import 'package:project_shelf/components/lists/product_list.dart';
import 'package:project_shelf/components/text_fields/custom_text_field.dart';
import 'package:project_shelf/database/database.dart';

class CreateInvoiceView extends ConsumerStatefulWidget {
  final String? restorationId;

  const CreateInvoiceView({this.restorationId, super.key});

  @override
  CreateInvoiceViewState createState() => CreateInvoiceViewState();
}

class CreateInvoiceViewState extends ConsumerState<CreateInvoiceView> {
  String? client;
  int? invoiceNumber;
  List<ProductData> products = [];

  void addProduct(ProductData product) {
    setState(() {
      products.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RestorationScope(
      restorationId: widget.restorationId,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Crear Factura'),
        ),
        //body: SearchProductDialog(),
        body: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            children: [
              CustomTextField(
                labelText: "Número de Factura",
                icon: FaIcon(FontAwesomeIcons.hashtag),
                initialValue: "1234",
                onChanged: (_) {},
                readOnly: true,
              ),
              Row(
                children: [
                  const Text("Productos"),
                  Spacer(),
                  SearchProductAnchor(
                    onTap: addProduct,
                  ),
                ],
              ),
              Expanded(
                child: ProductList(
                  list: products,
                  onTap: (id) {},
                ),
              ),
              ElevatedButton(
                onPressed: () => {},
                child: const Text("CREAR FACTURA"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
