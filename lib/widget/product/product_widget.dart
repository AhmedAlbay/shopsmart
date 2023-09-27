import 'dart:developer';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shopsmart_user/consts/app_constant.dart';
import 'package:shopsmart_user/widget/title.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          log('message');
        },
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FancyShimmerImage(
                imageUrl: AppConstant.imageUrl,
                width: double.infinity,
                height: size.height * .2,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Flexible(
                  flex: 5,
                  child: TitleTextWidget(
                    label: "title" * 10,
                    maxLine: 2,
                  ),
                ),
                Flexible(
                    child: IconButton(
                        onPressed: () {}, icon: const Icon(IconlyLight.heart))),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Flexible(
                  flex: 5,
                  child: TitleTextWidget(
                    label: "\$1654",
                    color: Colors.blue,
                  ),
                ),
                Flexible(
                    child: Material(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.lightBlue,
                  child: InkWell(
                    splashColor: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Icon(Icons.shopping_cart_checkout_sharp),
                    ),
                  ),
                )),
              ],
            ),
            const SizedBox(
              height: 7,
            ),
          ],
        ),
      ),
    );
  }
}
