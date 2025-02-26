import 'package:flutter/material.dart';
import 'package:project_shelf/database/database.dart';

class CustomerList extends StatelessWidget {
  final List<CustomerData> list;
  final void Function(String id) onTap;

  const CustomerList({
    required this.list,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (list.isNotEmpty) {
      return ListView.builder(
        itemCount: list.length,
        prototypeItem: ListTile(title: _ListItem(list[0])),
        itemBuilder: (context, index) => ListTile(
          title: _ListItem(list[index]),
          onTap: () => onTap(list[index].uuid),
        ),
      );
    }

    return const Text('sin productos boludo');
  }
}

class _ListItem extends StatelessWidget {
  final CustomerData data;

  const _ListItem(this.data);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.name),
        ],
      ),
    );
  }
}
