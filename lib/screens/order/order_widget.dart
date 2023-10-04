import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

import 'package:shopsmart_user/consts/app_constant.dart';

import 'package:shopsmart_user/widget/subtitle.dart';
import 'package:shopsmart_user/widget/title.dart';

class OrderWidgetFree extends StatelessWidget {
  const OrderWidgetFree({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      child: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: FancyShimmerImage(
            imageUrl: AppConstant.imageUrl,
            height: size.height * 0.2,
            width: size.height * 0.2,
          ),
        ),
        const SizedBox(
          width: 1,
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Flexible(
                      child: TitleTextWidget(
                        label: 'product title',
                        maxLine: 2,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    SubtitleTextWidget(
                      label: 'Price:',
                      fontSize: 20,
                    ),
                    SubtitleTextWidget(
                      label: '\$15',
                      color: Colors.blue,
                      fontSize: 20,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const SubtitleTextWidget(
                  label: 'Qty:10',
                  fontSize: 20,
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
