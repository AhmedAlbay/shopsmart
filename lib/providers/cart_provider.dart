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
  void updateQuantity({required String productId ,required int quantity}){
    _cartItem.update(
      productId,
      (item) => CartModel(
        cardId: item.cardId,
        productId: productId,
        quantity: quantity,
      ),
    );
    notifyListeners();
  }
}
