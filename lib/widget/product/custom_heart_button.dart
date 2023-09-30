import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class CustomHeartButton extends StatefulWidget {
  const CustomHeartButton({super.key, this.size = 22, this.color, this.color1});
  final double size;
  final Color? color;
   final Color? color1;
  @override
  State<CustomHeartButton> createState() => _CustomHeartButtonState();
}

class _CustomHeartButtonState extends State<CustomHeartButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.color,
      ),
      child: IconButton(
        style: IconButton.styleFrom(shape: const CircleBorder()),
        onPressed: () {},
        icon: Icon(
          IconlyLight.heart,
          size: widget.size,
          color:widget.color1 ,
        ),
      ),
    );
  }
}
