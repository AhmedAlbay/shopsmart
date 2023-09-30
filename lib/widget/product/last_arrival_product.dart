import 'dart:developer';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:shopsmart_user/consts/app_constant.dart';
import 'package:shopsmart_user/widget/product/custom_heart_button.dart';
import 'package:shopsmart_user/widget/title.dart';

class LastestArrivalProduct extends StatelessWidget {
  const LastestArrivalProduct({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: size.width * .45,
        child: GestureDetector(
          onTap: () {
            log('message');
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FancyShimmerImage(
                  imageUrl: AppConstant.imageUrl,
                  width: size.width * .27,
                  height: size.width * .27,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Title' * 10,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const FittedBox(
                      child: Row(
                        children: [
                          CustomHeartButton(),
                          Icon(
                            Icons.shopping_cart_checkout_sharp,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                    const FittedBox(
                      child: TitleTextWidget(
                        label: "\$1654",
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
