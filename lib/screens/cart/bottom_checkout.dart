import 'package:flutter/material.dart';
import 'package:shopsmart_user/widget/subtitle.dart';
import 'package:shopsmart_user/widget/title.dart';

class CartBottomCheckout extends StatelessWidget {
  const CartBottomCheckout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: const Border(top: BorderSide(width: 1))),
      child: SizedBox(
        height: kBottomNavigationBarHeight + 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
          child: Row(
            children: [
              const Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: TitleTextWidget(
                        label: 'Title(6 product / 6item)',
                      ),
                    ),
                    SubtitleTextWidget(
                      label: '\$1535',
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(onPressed: () {}, child: const Text('Checkout'))
            ],
          ),
        ),
      ),
    );
  }
}
