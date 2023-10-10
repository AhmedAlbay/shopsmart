import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_user/providers/product_provider.dart';
import 'package:shopsmart_user/services/assets_manager.dart';
import 'package:shopsmart_user/widget/product/product_widget_screach.dart';
import 'package:shopsmart_user/widget/search_textfield.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Search',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
            ),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(AssetsManager.shoppingCart),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SearchTextField(),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: DynamicHeightGridView(
                      itemCount: productProvider.getProducts.length,
                      builder: (context, index) {
                        return ChangeNotifierProvider.value(
                          value:productProvider.getProducts[index] ,
                          child:  ProductWidgetSearch(
                                productId:    productProvider.getProducts[index].productId        
                     ),
                        );
                      },
                      crossAxisCount: 2),
                ),
              ],
            ),
          )),
    );
  }
}
