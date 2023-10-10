import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_user/model/product_model.dart';
import 'package:shopsmart_user/providers/product_provider.dart';
import 'package:shopsmart_user/services/assets_manager.dart';
import 'package:shopsmart_user/widget/product/product_widget_screach.dart';
import 'package:shopsmart_user/widget/search_textfield.dart';
import 'package:shopsmart_user/widget/title.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  static const routeName = 'SearchScreen';
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    String? passcategory =
        ModalRoute.of(context)!.settings.arguments as String?;
    final List<ProductModel> productctgList = passcategory == null
        ? productProvider.getProducts
        : productProvider.findByCategory(ctgName: passcategory);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: TitleTextWidget(
              label: passcategory ?? 'Search',
              fontSize: 24,
            ),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(AssetsManager.shoppingCart),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: productctgList.isEmpty
                ? const Center(
                    child: TitleTextWidget(
                      label: 'No Product Found',
                      fontSize: 26,
                    ),
                  )
                : Column(
                    children: [
                      const SearchTextField(),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: DynamicHeightGridView(
                            itemCount: productctgList.length,
                            builder: (context, index) {
                              return ChangeNotifierProvider.value(
                                value: productctgList[index],
                                child: ProductWidgetSearch(
                                    productId: productctgList[index].productId),
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
