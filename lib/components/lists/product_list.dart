import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:project_shelf/database/database.dart";
import "package:project_shelf/lib/cop_currency.dart";

class ProductList extends StatelessWidget {
  final List<ProductData> list;
  final void Function(String id) onTap;

  const ProductList({
    required this.list,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (list.isNotEmpty) {
      return ListView.separated(
        itemCount: list.length,
        itemBuilder: (context, index) => ListTile(
          title: _ListItem(list[index]),
          onTap: () => onTap(list[index].id),
        ),
        separatorBuilder: (context, index) => Divider(),
      );
    }

    return const Text("sin productos boludo");
  }
}

class _ListItem extends StatelessWidget {
  final ProductData data;

  const _ListItem(this.data);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.name,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                CopCurrency.fromCents(data.value).toString(),
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Spacer(),
          Column(
            children: [
              Pill(iconData: FontAwesomeIcons.box, text: data.stock.toString()),
            ],
          ),
        ],
      ),
    );
  }
}

class Pill extends StatelessWidget {
  final IconData iconData;
  final String text;

  const Pill({required this.iconData, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        color: Colors.blue,
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 6),
            FaIcon(
              color: Colors.white,
              size: 16,
              FontAwesomeIcons.box,
            ),
          ],
        ),
      ),
    );
  }
}
