import 'package:flutter/material.dart';
import 'package:shopsmart_user/screens/order/order_widget.dart';
import 'package:shopsmart_user/services/assets_manager.dart';
import 'package:shopsmart_user/widget/empty_bag.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});
  static const routeName = 'OrderScreen';
  final bool isEmptyOrder = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Product Order',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: isEmptyOrder
            ? EmptyBagWidget(
                imagePath: AssetsManager.shoppingBasket,
                title: 'Whoops!',
                buttonText: 'Shop Now',
                subtitle: 'Your Order is Empty',
                subtitle1:
                    'Looks Like You Have Not Added Anything To Your Cart \nGo head & explore tops categories ',
              )
            : Scaffold(
                body: ListView.separated(
                  itemCount: 15,
                  itemBuilder: ((context, index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                      child: OrderWidgetFree(),
                    );
                  }),
                  separatorBuilder: ((context, index) {
                    return const Divider();
                  }),
                ),
              ));
  }
}
