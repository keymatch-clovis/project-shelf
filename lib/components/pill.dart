import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_shelf/lib/constants.dart';

class Pill extends StatelessWidget {
  final String text;

  final IconData? iconData;
  final Color? color;
  final Color? textColor;
  final double? width;
  final MainAxisAlignment? alignment;

  const Pill({
    required this.text,
    this.iconData,
    this.color,
    this.textColor,
    this.width,
    this.alignment,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: width,
        color: color ?? Theme.of(context).hintColor,
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
        child: Row(
          mainAxisAlignment: alignment ?? MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FaIcon(
              color: textColor,
              size: W14,
              iconData,
            ),
            const SizedBox(width: W6),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
