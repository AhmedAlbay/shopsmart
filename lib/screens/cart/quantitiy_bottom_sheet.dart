import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_user/model/cart_model.dart';
import 'package:shopsmart_user/providers/cart_provider.dart';
import 'package:shopsmart_user/widget/subtitle.dart';

class QuantityBottomSheet extends StatelessWidget {
  const QuantityBottomSheet({super.key, required this.cartModel});
  final CartModel cartModel;
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          width: 60,
          height: 6,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32), color: Colors.grey),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: 30,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      cartProvider.updateQuantity(
                        productId: cartModel.productId,
                        quantity: index + 1,
                      );
                      Navigator.pop(context);
                    },
                    child: GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Center(
                            child: SubtitleTextWidget(label: '${index + 1}')),
                      ),
                    ));
              }),
        ),
      ],
    );
  }
}
