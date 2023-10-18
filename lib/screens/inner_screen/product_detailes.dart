import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_user/providers/cart_provider.dart';

import 'package:shopsmart_user/providers/product_provider.dart';
import 'package:shopsmart_user/screens/cart/cart_screen.dart';
import 'package:shopsmart_user/widget/app_name_text.dart';
import 'package:shopsmart_user/widget/product/custom_heart_button.dart';
import 'package:shopsmart_user/widget/subtitle.dart';
import 'package:shopsmart_user/widget/title.dart';

class ProductDetailes extends StatefulWidget {
  static const routeName = 'ProductDetailes';
  const ProductDetailes({super.key});

  @override
  State<ProductDetailes> createState() => _ProductDetailesState();
}

class _ProductDetailesState extends State<ProductDetailes> {
  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final getCurrProduct = productProvider.findById(productId);
    final cartProvider = Provider.of<CartProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: AppNameText()),
        leading: IconButton(
            onPressed: () {
              Navigator.canPop(context) ? Navigator.pop(context) : null;
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        actions: [
          Flexible(
            child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, CartScreen.routeName);
                },
                icon: const Badge(
                    label: Text('6'), child: Icon(IconlyLight.bag2))),
          ),
        ],
      ),
      body: getCurrProduct == null
          ? const SizedBox.shrink()
          : SingleChildScrollView(
              child: Column(
                children: [
                  FancyShimmerImage(
                    height: size.height * .38,
                    width: double.infinity,
                    imageUrl: getCurrProduct.productImage,
                    boxFit: BoxFit.contain,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                                flex: 5,
                                child: Text(
                                  getCurrProduct.productTitle,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            const Spacer(),
                            const SizedBox(
                              width: 15,
                            ),
                            TitleTextWidget(
                              label: "${getCurrProduct.productPrice}\$",
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CustomHeartButton(
                                productId: getCurrProduct.productId,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: kBottomNavigationBarHeight - 10,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(24))),
                                    onPressed: () {
                                      cartProvider.addProductToCart(
                                          productId: productId);
                                    },
                                    icon: Icon(cartProvider.isProductInCart(
                                            productId: productId)
                                        ? Icons.done
                                        : Icons.add_shopping_cart),
                                    label: const Text("Add To Cart"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TitleTextWidget(
                              label: 'About Product',
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            SubtitleTextWidget(
                                label: getCurrProduct.productCategory)
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          getCurrProduct.productDescription,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
