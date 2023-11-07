import 'package:flutter/material.dart';
import 'package:shopsmart_user/model/view_product_model.dart';

import 'package:uuid/uuid.dart';

class ViewProductProvider with ChangeNotifier {
  final Map<String, ViewProductModel> _viewProductItem = {};
  Map<String, ViewProductModel> get getviewProductItem {
    return _viewProductItem;
  }

  bool isProductInviewProduct({required String productId}) {
    return _viewProductItem.containsKey(productId);
  }

  void addviewProductToHistory({required String productId}) {
    _viewProductItem.putIfAbsent(productId,
        () => ViewProductModel(id: const Uuid().v4(), productId: productId));

    notifyListeners();
  }
   void clearLocaViewRecent() {
    _viewProductItem.clear();
    notifyListeners();
  }
}
