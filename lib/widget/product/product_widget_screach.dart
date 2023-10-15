import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_user/providers/cart_provider.dart';
import 'package:shopsmart_user/providers/product_provider.dart';
import 'package:shopsmart_user/providers/view_product_provider.dart';
import 'package:shopsmart_user/screens/inner_screen/product_detailes.dart';
import 'package:shopsmart_user/widget/product/custom_heart_button.dart';
import 'package:shopsmart_user/widget/title.dart';

class ProductWidgetSearch extends StatefulWidget {
  const ProductWidgetSearch({super.key, required this.productId});
  final String productId;
  @override
  State<ProductWidgetSearch> createState() => _ProductWidgetSearchState();
}

class _ProductWidgetSearchState extends State<ProductWidgetSearch> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final getCurrProduct = productProvider.findById(widget.productId);
    final viewProduct = Provider.of<ViewProductProvider>(context);

    Size size = MediaQuery.of(context).size;
    return getCurrProduct == null
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(3.0),
            child: GestureDetector(
              onTap: () {
                viewProduct.addviewProductToHistory(
                    productId: getCurrProduct.productId);
                Navigator.pushNamed(context, ProductDetailes.routeName,
                    arguments: getCurrProduct.productId);
              },
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: FancyShimmerImage(
                      imageUrl: getCurrProduct.productImage,
                      height: size.height * .2,
                      width: double.infinity,
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
                          label: getCurrProduct.productTitle,
                          maxLine: 2,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Flexible(
                        flex: 2,
                        child: CustomHeartButton(
                          productId: getCurrProduct.productId,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 5,
                        child: TitleTextWidget(
                          label: "${getCurrProduct.productPrice}\$",
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
                            onTap: () {
                              if (cartProvider.isProductInCart(
                                  productId: getCurrProduct.productId)) {
                                return;
                              }
                              cartProvider.addProductToCart(
                                  productId: getCurrProduct.productId);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(
                                cartProvider.isProductInCart(
                                        productId: getCurrProduct.productId)
                                    ? Icons.check
                                    : Icons.shopping_cart_checkout_sharp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
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
