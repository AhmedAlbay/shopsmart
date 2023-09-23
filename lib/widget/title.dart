import 'package:flutter/material.dart';

class TitleTextWidget extends StatelessWidget {
  const TitleTextWidget(
      {super.key,
      required this.label,
      required this.fontSize,
      required this.fontWeight,
      this.color,
      required this.fontStyle,
      required this.textDecoration, this.maxLine});
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
