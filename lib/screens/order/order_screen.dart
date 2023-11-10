import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_user/providers/order_provider.dart';
import 'package:shopsmart_user/screens/order/order_widget.dart';
import 'package:shopsmart_user/services/assets_manager.dart';
import 'package:shopsmart_user/widget/empty_bag.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});
  static const routeName = 'OrderScreen';
  final bool isEmptyOrder = false;
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
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
      body: FutureBuilder(
        future: orderProvider.fetchOrders(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child:
                  SelectableText("An error has been occured ${snapshot.error}"),
            );
          } else if (!snapshot.hasData||orderProvider.getOrders.isEmpty) {
            return EmptyBagWidget(
              imagePath: AssetsManager.shoppingBasket,
              title: 'Whoops!',
              buttonText: 'Shop Now',
              subtitle: 'Your Order is Empty',
              subtitle1:
                  'Looks Like You Have Not Added Anything To Your Cart \nGo head & explore tops categories ',
            );
          } else {
            return ListView.separated(
              itemCount: snapshot.data!.length,
              itemBuilder: ((context, index) {
                return  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                  child: OrderWidgetFree(orderModelAdvanced: orderProvider.getOrders[index],),
                );
              }),
              separatorBuilder: ((context, index) {
                return const Divider();
              }),
            );
          }
        }),
      ),
    );
  }
}
