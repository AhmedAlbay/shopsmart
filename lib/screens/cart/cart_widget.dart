import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shopsmart_user/widget/subtitle.dart';
import 'package:shopsmart_user/widget/title.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return IntrinsicWidth(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FittedBox(
          child: Row(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: FancyShimmerImage(
                imageUrl:
                    'https://images.pexels.com/photos/4158/apple-iphone-smartphone-desk.jpg?auto=compress&cs=tinysrgb&w=600',
                height: size.height * 0.2,
                width: size.height * 0.2,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            IntrinsicWidth(
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: size.width * .6,
                        child: TitleTextWidget(
                          label: 'Title' * 10,
                          maxLine: 2,
                        ),
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.red,
                              size: 30,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              IconlyLight.heart,
                              color: Colors.red,
                              size: 30,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const SubtitleTextWidget(
                        label: '\$15',
                        color: Colors.blue,
                        fontSize: 24,
                      ),
                      const Spacer(),
                      OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16))),
                          onPressed: () {},
                          icon: const Icon(
                            IconlyLight.arrowDown,
                            size: 35,
                          ),
                          label: const Text(
                            'ouly:2',
                            style: TextStyle(fontSize: 24),
                          ))
                    ],
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
