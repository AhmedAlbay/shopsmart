import 'package:flutter/material.dart';
import 'package:shopsmart_user/screens/cart/bottom_checkout.dart';
import 'package:shopsmart_user/screens/cart/cart_widget.dart';
import 'package:shopsmart_user/services/assets_manager.dart';
import 'package:shopsmart_user/widget/empty_bag.dart';

class CartScreen extends StatelessWidget {
  static const routeName = 'CartScreen';
  const CartScreen({super.key});
  final bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    return isEmpty
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
              title: const Text(
                'Shopping Products',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AssetsManager.shoppingCart),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete_forever_rounded),
                ),
              ],
            ),
            body: ListView.builder(
              itemCount: 15,
              itemBuilder: (context, index) {
                return const CartWidget();
              },
            ),
            bottomSheet: const CartBottomCheckout(),
          );
  }
}
