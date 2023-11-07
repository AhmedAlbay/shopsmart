import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_user/model/product_model.dart';
import 'package:shopsmart_user/providers/cart_provider.dart';
import 'package:shopsmart_user/providers/view_product_provider.dart';
import 'package:shopsmart_user/screens/inner_screen/product_detailes.dart';
import 'package:shopsmart_user/services/my_app_method.dart';
import 'package:shopsmart_user/widget/product/custom_heart_button.dart';
import 'package:shopsmart_user/widget/title.dart';

class LastestArrivalProduct extends StatelessWidget {
  const LastestArrivalProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);
    final viewProduct = Provider.of<ViewProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: size.width * .45,
        child: GestureDetector(
          onTap: () {
            viewProduct.addviewProductToHistory(
                productId: productModel.productId);
            Navigator.pushNamed(context, ProductDetailes.routeName,
                arguments: productModel.productId);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FancyShimmerImage(
                  imageUrl: productModel.productImage,
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
                      productModel.productTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          CustomHeartButton(
                            productId: productModel.productId,
                          ),
                          IconButton(
                            onPressed: ()async {
                              if (cartProvider.isProductInCart(
                                  productId: productModel.productId)) {
                                return;
                              }
                              try {
                                await cartProvider.addToCartFirebase(
                                    productId: productModel.productId,
                                    qty: 1,
                                    context: context);
                              } catch (error ) {
                                // ignore: use_build_context_synchronously
                                MyAppMethod.showErrowWariningDialog(
                                    context: context,
                                    subTitle: error.toString(),
                                    function: () {});
                              }
                            },
                            icon: Icon(
                              cartProvider.isProductInCart(
                                      productId: productModel.productId)
                                  ? Icons.done
                                  : Icons.shopping_cart_checkout_outlined,
                              size: 26,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FittedBox(
                      child: TitleTextWidget(
                        label: "${productModel.productPrice}\$",
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
