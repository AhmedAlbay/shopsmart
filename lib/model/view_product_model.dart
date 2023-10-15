import 'package:flutter/material.dart';

class ViewProductModel with ChangeNotifier {
  final String id, productId;

  ViewProductModel({
    required this.id,
    required this.productId,
  });
}
