import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopsmart_user/model/order_model.dart';

class OrderProvider with ChangeNotifier {
  final List<OrderModelAdvanced> orders = [];
  List<OrderModelAdvanced> get getOrders => orders;
  Future<List<OrderModelAdvanced>> fetchOrders() async {
    final auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    // ignore: unused_local_variable
    var uid = user!.uid;
    try {
      await FirebaseFirestore.instance
          .collection('orderAdvanced')
          .get()
          .then((orderSnapshot) {
        orders.clear();
        for (var element in orderSnapshot.docs) {
          orders.insert(
            0,
            OrderModelAdvanced(
              orderId: element.get("orderId"),
              userId: element.get("userId"),
              productId: element.get("productId"),
              productTitle: element.get("productTitle"),
              userName: element.get(" userName"),
              price: element.get("price").toString(),
              imageUrl: element.get("imageUrl"),
              quantity: element.get("quantity").toString(),
              orderData: element.get("orderData"),
            ),
          );
        }
      });
      return orders;
    } catch (error) {
      rethrow;
    }
  }
}
