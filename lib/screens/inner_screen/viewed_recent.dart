import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';

import 'package:shopsmart_user/services/assets_manager.dart';
import 'package:shopsmart_user/widget/empty_bag.dart';
import 'package:shopsmart_user/widget/product/product_widget_screach.dart';

class ViewedRecentScreen extends StatelessWidget {
  static const routeName = 'ViewedRecentScreen';
  const ViewedRecentScreen({super.key});
  final bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    return isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
              imagePath: AssetsManager.shoppingBasket,
              title: 'Whoops!',
              buttonText: 'Shop Now',
              subtitle: 'Your WishList is Empty',
              subtitle1:
                  'Looks Like You Have Not Added Anything To Your Cart \nGo head & explore tops categories ',
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text(
                'ViewedRecent',
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
            body:  DynamicHeightGridView(
                itemCount: 200,
                builder: (context, index) {
                  return  const ProductWidgetSearch(
                    productId: '',
                  );
                },
                crossAxisCount: 2)
          );
  }
}
