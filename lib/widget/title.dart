import 'package:flutter/material.dart';

class TitleTextWidget extends StatelessWidget {
  const TitleTextWidget(
      {super.key,
      required this.label,
      this.fontSize = 18,
      this.fontWeight = FontWeight.w800,
      this.color,
      this.fontStyle = FontStyle.normal,
      this.textDecoration = TextDecoration.none,
      this.maxLine});
  final String label;
  final int? maxLine;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final FontStyle fontStyle;
  final TextDecoration textDecoration;
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      maxLines: maxLine,
      style: TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          decoration: textDecoration,
          color: color),
    );
  }
}
