import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_shelf/adapter/view_model/product_view_model.dart';
import 'package:project_shelf/shared/constants.dart';

class ProductList extends StatelessWidget {
  final AsyncValue<List<ProductViewModel>> asyncValue;

  const ProductList(this.asyncValue, {super.key});

  @override
  Widget build(BuildContext context) {
    return switch (asyncValue) {
      AsyncData(:final value) => render(context, value),
      AsyncError(:final error) => Text("Error: $error"),
      _ => const Center(child: CircularProgressIndicator())
    };
  }

  Widget render(BuildContext context, List<ProductViewModel> products) {
    if (products.isEmpty) {
      return Center(child: Text("Sin productos", style: TEXT_STONE_600));
    }

    return ListView.separated(
      itemCount: products.length,
      separatorBuilder: (_, __) => Divider(height: 0),
      itemBuilder: (_, index) => ListTile(
        tileColor: Colors.white,
        title: Text(products[index].name),
      ),
    );
  }
}
