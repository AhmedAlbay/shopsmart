import 'package:flutter/material.dart';
import 'package:shopsmart_user/services/assets_manager.dart';
import 'package:shopsmart_user/widget/empty_bag.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: EmptyBagWidget(
      imagePath: AssetsManager.shoppingBasket,
      title: 'Whoops!',
      buttonText: 'Shop Now',
      subtitle: 'Your Cart is Empty',
      subtitle1:
          'Looks Like You Have Not Added Anything To Your Cart \nGo head & explore tops categories ',
    ));
  }
}
