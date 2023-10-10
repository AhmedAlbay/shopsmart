import 'package:flutter/material.dart';
import 'package:shopsmart_user/model/cart_model.dart';
import 'package:uuid/uuid.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartModel> _cartItem = {};
  Map<String, CartModel> get getCartItem {
    return _cartItem;
  }

  bool isProductInCart({required String productId}) {
    return _cartItem.containsKey(productId);
  }

  void addProductToCart({required String productId}) {
    _cartItem.putIfAbsent(
      productId,
      () => CartModel(
        cardId: const Uuid().v4(),
        productId: productId,
        quantity: 1,
      ),
    );
    notifyListeners();
  }
}
