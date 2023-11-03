import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_user/consts/app_constant.dart';
import 'package:shopsmart_user/providers/product_provider.dart';
import 'package:shopsmart_user/services/assets_manager.dart';
import 'package:shopsmart_user/widget/app_name_text.dart';
import 'package:shopsmart_user/widget/product/categories_rounded_widget.dart';
import 'package:shopsmart_user/widget/product/last_arrival_product.dart';
import 'package:shopsmart_user/widget/title.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const AppNameText(),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.shoppingCart),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * .24,
                child: Swiper(
                  autoplay: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Image.asset(
                      AppConstant.imageBanners[index],
                      fit: BoxFit.fill,
                    );
                  },
                  itemCount: AppConstant.imageBanners.length,
                  pagination: const SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                          color: Colors.white, activeColor: Colors.red)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Visibility(
                visible: productProvider.getProducts.isNotEmpty,
                child: const TitleTextWidget(
                  label: 'Lastest arrival',
                  fontSize: 26,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Visibility(
                visible: productProvider.getProducts.isNotEmpty,
                child: SizedBox(
                  height: size.height * .2,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productProvider.getProducts.length < 10
                        ? productProvider.getProducts.length
                        : 10,
                    itemBuilder: ((context, index) {
                      return ChangeNotifierProvider.value(
                          value: productProvider.getProducts[index],
                          child: const LastestArrivalProduct());
                    }),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const TitleTextWidget(
                label: 'Categories',
                fontSize: 24,
              ),
              const SizedBox(
                height: 15,
              ),
              GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  children: List.generate(AppConstant.categoriesProduct.length,
                      (index) {
                    return CategoryRoundedWidget(
                        image: AppConstant.categoriesProduct[index].image,
                        name: AppConstant.categoriesProduct[index].name);
                  })),
            ],
          ),
        ),
      ),
    );
  }
}
