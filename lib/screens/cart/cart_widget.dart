import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_user/model/cart_model.dart';
import 'package:shopsmart_user/providers/cart_provider.dart';
import 'package:shopsmart_user/providers/product_provider.dart';
import 'package:shopsmart_user/screens/cart/quantitiy_bottom_sheet.dart';
import 'package:shopsmart_user/services/my_app_method.dart';
import 'package:shopsmart_user/widget/product/custom_heart_button.dart';
import 'package:shopsmart_user/widget/subtitle.dart';
import 'package:shopsmart_user/widget/title.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cartModelProvider = Provider.of<CartModel>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    final getCurrProduct =
        productProvider.findById(cartModelProvider.productId);
    Size size = MediaQuery.of(context).size;
    return IntrinsicWidth(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: getCurrProduct == null
            ? const SizedBox.shrink()
            : FittedBox(
                child: Row(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: FancyShimmerImage(
                      imageUrl: getCurrProduct.productImage,
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
                                label: getCurrProduct.productTitle,
                                maxLine: 2,
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    MyAppMethod.showErrowWariningDialog(
                                        context: context,
                                        subTitle: "Sure Remove Item",
                                        isError: true,
                                        function: () async {
                                          await cartProvider
                                              .removeItemCartFromFirebase(
                                            cartId: cartModelProvider.cartId,
                                            productId:
                                                cartModelProvider.productId,
                                            quantity:
                                                cartModelProvider.quantity,
                                          );
                                          // cartProvider.removeOneItem(
                                          //     productId:
                                          //         getCurrProduct.productId);
                                        });
                                  },
                                  icon: const Icon(
                                    Icons.clear,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                ),
                                CustomHeartButton(
                                  productId: getCurrProduct.productId,
                                  size: 24,
                                  color1: Colors.red,
                                )
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SubtitleTextWidget(
                              label: '${getCurrProduct.productPrice}\$',
                              color: Colors.blue,
                              fontSize: 24,
                            ),
                            const Spacer(),
                            OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16))),
                                onPressed: () async {
                                  await showModalBottomSheet(
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(16),
                                            topRight: Radius.circular(16)),
                                      ),
                                      context: context,
                                      builder: (context) {
                                        return QuantityBottomSheet(
                                          cartModel: cartModelProvider,
                                        );
                                      });
                                },
                                icon: const Icon(
                                  IconlyLight.arrowDown,
                                  size: 35,
                                ),
                                label: Text(
                                  'ouly:${cartModelProvider.quantity}',
                                  style: const TextStyle(fontSize: 24),
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
