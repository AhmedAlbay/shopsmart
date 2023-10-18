import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_user/providers/view_product_provider.dart';

import 'package:shopsmart_user/services/assets_manager.dart';
import 'package:shopsmart_user/widget/empty_bag.dart';
import 'package:shopsmart_user/widget/product/product_widget_screach.dart';

class ViewedRecentScreen extends StatelessWidget {
  static const routeName = 'ViewedRecentScreen';
  const ViewedRecentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewProduct = Provider.of<ViewProductProvider>(context);

    return viewProduct.getviewProductItem.isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
              imagePath: AssetsManager.shoppingBasket,
              title: 'Whoops!',
              buttonText: 'Shop Now' ,
              subtitle: 'Your WishList is Empty',
              subtitle1:
                  'Looks Like You Have Not Added Anything To Your Cart \nGo head & explore tops categories ',
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                'ViewedRecent(${viewProduct.getviewProductItem.length})',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
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
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: DynamicHeightGridView(
                  itemCount: viewProduct.getviewProductItem.length,
                  builder: (context, index) {
                    return ProductWidgetSearch(
                      productId: viewProduct.getviewProductItem.values
                          .toList()[index]
                          .productId,
                    );
                  },
                  crossAxisCount: 2),
            ));
  }
}
