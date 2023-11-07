import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopsmart_user/model/cart_model.dart';
import 'package:shopsmart_user/model/product_model.dart';
import 'package:shopsmart_user/providers/product_provider.dart';
import 'package:uuid/uuid.dart';

class CartProvider with ChangeNotifier {
  final auth = FirebaseAuth.instance;
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
        cartId: const Uuid().v4(),
        productId: productId,
        quantity: 1,
      ),
    );
    notifyListeners();
  }

  double getTotal({required ProductProvider productProvider}) {
    double total = 0.0;
    _cartItem.forEach((key, value) {
      final ProductModel? getCurrProduct =
          productProvider.findById(value.productId);
      if (getCurrProduct == null) {
        total += 0;
      } else {
        total += double.parse(getCurrProduct.productPrice) * value.quantity;
      }
    });
    return total;
  }

  int getQty() {
    int total = 0;
    _cartItem.forEach((key, value) {
      total += value.quantity;
    });
    return total;
  }

  void removeOneItem({required String productId}) {
    _cartItem.remove(productId);
    notifyListeners();
  }

  void clearLocalCart() {
    _cartItem.clear();
    notifyListeners();
  }

  final usersDB = FirebaseFirestore.instance.collection("users");
  Future<void> addToCartFirebase(
      {required String productId,
      required int qty,
      required BuildContext context}) async {
    final User? user = auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please Login')));
      return;
    }

    final uid = user.uid;
    final cartId = const Uuid().v4();
    try {
      usersDB.doc(uid).update({
        "userCart": FieldValue.arrayUnion([
          {
            "cartId": cartId,
            "quantity": qty,
            "productId": productId,
          }
        ])
      });
      await fetchCart();
      Fluttertoast.showToast(msg: "Item has been added to cart");
    } catch (error) {
      rethrow;
    }
  }
//  Future<void> fetchCart() async {
//   final User? user = auth.currentUser;
//   if (user == null) {
//  _cartItem.clear();
//     return;
//   }

//   try {
//     final userDoc = await usersDB.doc(user.uid).get();
//     final data = userDoc.data();
    
//     if (data == null || !data.containsKey("userCart")) {
//       // If user data is not found or "userCart" key is not present, handle it as needed.
//       // You can return an error or perform other actions.
//       return;
//     }

//     final userCart = data["userCart"] as List<dynamic>;

//     _cartItem.clear();

//     for (int index = 0; index < userCart.length; index++) {
//       final cartItem = userCart[index];
      
//       final String cartId = cartItem["cartId"];
//       final String productId = cartItem["productId"];
//       final int quantity = cartItem["quantity"];


//       _cartItem.putIfAbsent(
//         productId,
//         () => CartModel(
//           cartId: cartId,
//           productId: productId,
//           quantity: quantity,
//         ),
//       );
//     }
//   } catch (error) {
//     // Handle errors as needed.
//     // You can log the error, return an error, or perform other actions.
//     rethrow;
//   }

//   // Notify listeners or perform any other post-processing as needed.
//   notifyListeners();
// }



  Future<void> fetchCart() async {
    final User? user = auth.currentUser;
    // ignore: unused_local_variable
    final uid = user?.uid;
    if (user == null) {
      _cartItem.clear();
      return;
    }

    try {
      final userDoc = await usersDB.doc(user.uid).get();
      final data = userDoc.data();
      if (data == null || !data.containsKey("userCart")) {
        return;
      }

      final leng = userDoc.get("userCart").length;
      for (int index = 0; index < leng; index++) {
        _cartItem.putIfAbsent(
          userDoc.get("userCart")[index]["productId"],
          () => CartModel(
            cartId: userDoc.get("userCart")[index]["cartId"],
            productId: userDoc.get("userCart")[index]["productId"],
            quantity: userDoc.get("userCart")[index]["quantity"],
          ),
        );
      }
    } catch (error) {
      rethrow;
    }
    notifyListeners();
  }

  void updateQuantity({required String productId, required int quantity}) {
    _cartItem.update(
      productId,
      (item) => CartModel(
        cartId: item.cartId,
        productId: productId,
        quantity: quantity,
      ),
    );
    notifyListeners();
  }
}
