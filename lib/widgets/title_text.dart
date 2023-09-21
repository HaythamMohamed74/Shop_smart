import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText(
      {this.maxLines,
      this.textColor,
      this.fontSize = 20,
      super.key,
      required this.label});
  final String label;
  final int? maxLines;
  final Color? textColor;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: textColor, fontSize: fontSize, fontWeight: FontWeight.bold),
    );
  }
}
