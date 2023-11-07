import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_user/model/product_model.dart';
import 'package:shopsmart_user/providers/product_provider.dart';
import 'package:shopsmart_user/services/assets_manager.dart';
import 'package:shopsmart_user/widget/product/product_widget_screach.dart';
import 'package:shopsmart_user/widget/title.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  static const routeName = 'SearchScreen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchTextController;
  @override
  void initState() {
    searchTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  List<ProductModel> productListSearch = [];

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
                : StreamBuilder<List<ProductModel>>(
                    stream: productProvider.fetchProductStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                          child: TitleTextWidget(
                              label: snapshot.hasError.toString()),
                        );
                      }
                      else if (snapshot.data ==null){
                         return const Center(
                          child: TitleTextWidget(
                              label: "NO Product Founded"),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: searchTextController,
                              decoration: InputDecoration(
                                filled: true,
                                hintText: 'Search',
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.blue,
                                ),
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                      searchTextController.clear();
                                      FocusScope.of(context).unfocus();
                                      });
                                    },
                                    child: const Icon(
                                      Icons.clear,
                                      color: Colors.red,
                                    )),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  productListSearch =
                                      productProvider.searchProduct(
                                          searchText: searchTextController.text,
                                          passedList: productListSearch);
                                });
                              },
                              onSubmitted: (value) {
                                setState(() {
                                  productListSearch =
                                      productProvider.searchProduct(
                                          searchText: searchTextController.text,
                                          passedList: productListSearch);
                                });
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            if (searchTextController.text.isNotEmpty &&
                                productListSearch.isEmpty) ...[
                              const Center(
                                child: TitleTextWidget(
                                  label: "No Result Found",
                                  fontSize: 28,
                                ),
                              )
                            ],
                            Expanded(
                              child: DynamicHeightGridView(
                                  itemCount:
                                      searchTextController.text.isNotEmpty
                                          ? productListSearch.length
                                          : productctgList.length,
                                  builder: (context, index) {
                                    return ProductWidgetSearch(
                                        productId: searchTextController
                                                .text.isNotEmpty
                                            ? productListSearch[index].productId
                                            : productctgList[index].productId);
                                  },
                                  crossAxisCount: 2),
                            ),
                          ],
                        ),
                      );
                    }),
          )),
    );
  }
}
