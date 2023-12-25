import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

import 'package:shopsmart_user/model/order_model.dart';

import 'package:shopsmart_user/widget/subtitle.dart';
import 'package:shopsmart_user/widget/title.dart';

class OrderWidgetFree extends StatelessWidget {
  const OrderWidgetFree({super.key, required this.orderModelAdvanced});
  final OrderModelAdvanced orderModelAdvanced;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      child: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: FancyShimmerImage(
            imageUrl:orderModelAdvanced.imageUrl,
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
                     Flexible(
                      child: TitleTextWidget(
                        label:orderModelAdvanced.productTitle ,
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
                 Row(
                  children: [
                    const SubtitleTextWidget(
                      label: 'Price:',
                      fontSize: 20,
                    ),
                    SubtitleTextWidget(
                      label: '${orderModelAdvanced.price}\$',
                      color: Colors.blue,
                      fontSize: 20,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                 SubtitleTextWidget(
                  label: 'Qty:${orderModelAdvanced.quantity}',
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
