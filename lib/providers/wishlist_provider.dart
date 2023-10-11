import 'package:flutter/material.dart';

import 'package:shopsmart_user/model/wish_list_model.dart';
import 'package:uuid/uuid.dart';

class WishListProvider with ChangeNotifier {
  final Map<String, WishListModel> _wishListItem = {};
  Map<String, WishListModel> get getWishListItem {
    return _wishListItem;
  }

  bool isProductInWishList({required String productId}) {
    return _wishListItem.containsKey(productId);
  }

  void addOrRemoveProductToWishList({required String productId}) {
    if (_wishListItem.containsKey(productId)) {
      _wishListItem.remove(productId);
    } else {
      _wishListItem.putIfAbsent(productId,
          () => WishListModel(id:const  Uuid().v4(), productId: productId));
    }

    notifyListeners();
  }

  void clearLocalWishList() {
    _wishListItem.clear();
    notifyListeners();
  }
}
