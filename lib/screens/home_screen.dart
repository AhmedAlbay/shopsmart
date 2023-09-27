import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:shopsmart_user/consts/app_constant.dart';
import 'package:shopsmart_user/services/assets_manager.dart';
import 'package:shopsmart_user/widget/app_name_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        child: Column(
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
          ],
        ),
      ),
    );
  }
}
