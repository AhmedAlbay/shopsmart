// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_user/providers/cart_provider.dart';
import 'package:shopsmart_user/providers/product_provider.dart';
import 'package:shopsmart_user/providers/user_provider.dart';
import 'package:shopsmart_user/screens/cart/bottom_checkout.dart';
import 'package:shopsmart_user/screens/cart/cart_widget.dart';
import 'package:shopsmart_user/screens/inner_screen/loading_manager.dart';
import 'package:shopsmart_user/services/assets_manager.dart';
import 'package:shopsmart_user/services/my_app_method.dart';
import 'package:shopsmart_user/widget/empty_bag.dart';
import 'package:uuid/uuid.dart';

class CartScreen extends StatefulWidget {
  static const routeName = 'CartScreen';
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // final bool isEmpty = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    return cartProvider.getCartItem.isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
              imagePath: AssetsManager.shoppingBasket,
              title: 'Whoops!',
              buttonText: 'Shop Now',
              subtitle: 'Your Cart is Empty',
              subtitle1:
                  'Looks Like You Have Not Added Anything To Your Cart \nGo head & explore tops categories ',
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                'Cart (${cartProvider.getCartItem.length})',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AssetsManager.shoppingCart),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    MyAppMethod.showErrowWariningDialog(
                        context: context,
                        isError: true,
                        subTitle: "Sure Removing All Item",
                        fontsize: 24,
                        function: () async {
                          await cartProvider.clearCartFromFirebase();
                        });
                  },
                  icon: const Icon(Icons.delete_forever_rounded),
                ),
              ],
            ),
            body: LoadingManager(
              isLoading: isLoading,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartProvider.getCartItem.length,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                            value: cartProvider.getCartItem.values
                                .toList()
                                .reversed
                                .toList()[index],
                            child: const CartWidget());
                      },
                    ),
                  ),
                  const SizedBox(
                    height: kBottomNavigationBarHeight + 10,
                  ),
                ],
              ),
            ),
            bottomSheet: CartBottomCheckout(
              function: () async {
                placeOrder(
                    cartProvider: cartProvider,
                    productProvider: productProvider,
                    userProvider: userProvider);
              },
            ),
          );
  }

  Future<void> placeOrder({
    required CartProvider cartProvider,
    required ProductProvider productProvider,
    required UserProvider userProvider,
  }) async {
    final auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.uid;
    if (user == null) {
      MyAppMethod.showErrowWariningDialog(
          context: context, subTitle: "Please Login", function: () {});
    }
    try {
      setState(() {
        isLoading = true;
      });
      cartProvider.getCartItem.forEach((key, value) async {
        final getCurrProduct = productProvider.findById(value.productId);
        final orderId = const Uuid().v4();
        await FirebaseFirestore.instance
            .collection("orderAdvanced")
            .doc(orderId)
            .set({
          "orderId": orderId,
          "userId": uid,
          "productId": value.productId,
          "productTitle": getCurrProduct!.productTitle,
          "price": double.parse(getCurrProduct.productPrice) ,
          "totalPrice": cartProvider.getTotal(productProvider: productProvider),
          "quantity": value.quantity,
          "imageUrl": getCurrProduct.productImage,
          " userName": userProvider.getUserModel!.userName,
          "orderData": Timestamp.now(),
        });
      });
      await cartProvider.clearCartFromFirebase();
      cartProvider.clearLocalCart();
    } catch (error) {
      MyAppMethod.showErrowWariningDialog(
          context: context, subTitle: error.toString(), function: () {});
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
