import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Pill extends StatelessWidget {
  final IconData iconData;
  final String text;
  final MaterialColor color;

  const Pill({
    required this.iconData,
    required this.text,
    this.color = Colors.blue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        color: color,
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
            const SizedBox(width: 6),
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
