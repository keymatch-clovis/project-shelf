import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_shelf/database/database.dart';

class ProductList extends StatelessWidget {
  final List<ProductData> list;

  const ProductList({required this.list, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      prototypeItem: ListTile(title: _ListItem(list[0])),
      itemBuilder: (context, index) => ListTile(
        title: _ListItem(list[index]),
        onTap: () => debugPrint(index.toString()),
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final ProductData data;

  const _ListItem(this.data);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.name),
          Text(
            NumberFormat.currency(name: 'COP').format(data.value),
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
