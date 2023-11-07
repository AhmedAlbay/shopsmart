import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shopsmart_user/model/wish_list_model.dart';
import 'package:uuid/uuid.dart';

class WishListProvider with ChangeNotifier {
  final Map<String, WishListModel> _wishListItem = {};
  Map<String, WishListModel> get getWishListItem {
    return _wishListItem;
  }

//local data
  bool isProductInWishList({required String productId}) {
    return _wishListItem.containsKey(productId);
  }

  void addOrRemoveProductToWishList({required String productId}) {
    if (_wishListItem.containsKey(productId)) {
      _wishListItem.remove(productId);
    } else {
      _wishListItem.putIfAbsent(productId,
          () => WishListModel(id: const Uuid().v4(), productId: productId));
    }

    notifyListeners();
  }

  void clearLocalWishList() {
    _wishListItem.clear();
    notifyListeners();
  }
  //firebase

  final auth = FirebaseAuth.instance;
  final usersDB = FirebaseFirestore.instance.collection("users");
  Future<void> addWishListFirebase({
    required String productId,
    required BuildContext context,
  }) async {
    final User? user = auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please Login')));
      return;
    }

    final uid = user.uid;
    final wishListId = const Uuid().v4();
    try {
      usersDB.doc(uid).update({
        "userWish": FieldValue.arrayUnion([
          {
            "wishListId": wishListId,
            "productId": productId,
          }
        ])
      });
      await fetchWishList();
      Fluttertoast.showToast(msg: "Item has been added to WishList");
    } catch (error) {
      rethrow;
    }
  }

  Future<void> clearWishListFromFirebase() async {
    final User? user = auth.currentUser;
    if (user == null) {
      throw Exception("No user logged in");
    }
    try {
      final uid = user.uid;
      await usersDB.doc(uid).update({"userWish": []});
      _wishListItem.clear();
    } catch (error) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> removeItemWishListFromFirebase({
    required String wishListId,
    required String productId,
  }) async {
    final User? user = auth.currentUser;
    if (user == null) {
      throw Exception("No user logged in");
    }
    try {
      final uid = user.uid;
      await usersDB.doc(uid).update({
        "userWish": FieldValue.arrayRemove([
          {
            "wishListId": wishListId,
            "productId": productId,
          }
        ])
      });
      _wishListItem.remove(productId);
      await fetchWishList();
    } catch (error) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> fetchWishList() async {
    final User? user = auth.currentUser;
    // ignore: unused_local_variable
    final uid = user?.uid;
    if (user == null) {
      _wishListItem.clear();
      return;
    }

    try {
      final userDoc = await usersDB.doc(user.uid).get();
      final data = userDoc.data();
      if (data == null || !data.containsKey("userWish")) {
        return;
      }

      final leng = userDoc.get("userWish").length;
      for (int index = 0; index < leng; index++) {
        _wishListItem.putIfAbsent(
            userDoc.get("userWish")[index]["productId"],
            () => WishListModel(
                  id: userDoc.get("userWish")[index]["wishListId"],
                  productId: userDoc.get("userWish")[index]["productId"],
                ));
      }
    } catch (error) {
      rethrow;
    }
    notifyListeners();
  }
}
