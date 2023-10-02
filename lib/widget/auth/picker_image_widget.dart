import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickerImageWidget extends StatelessWidget {
  const PickerImageWidget(
      {super.key, required this.pickerImage, required this.function});
  final XFile? pickerImage;
  final Function function;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: pickerImage == null
              ? Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(8),
                  ),
                )
              : Image.file(
                  File(pickerImage!.path),
                  fit: BoxFit.cover,
                ),
        ),
      ),
      Positioned(
        top: 0,
        right: 0,
        child: Material(
          borderRadius: BorderRadius.circular(8),
          color: Colors.lightBlue,
          child: InkWell(
            splashColor: Colors.red,
            borderRadius: BorderRadius.circular(8),
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.all(5.0),
              child: Icon(
                Icons.shopping_cart_checkout_sharp,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
