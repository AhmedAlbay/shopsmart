import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_user/model/product_model.dart';
import 'package:shopsmart_user/screens/inner_screen/product_detailes.dart';
import 'package:shopsmart_user/widget/product/custom_heart_button.dart';
import 'package:shopsmart_user/widget/title.dart';

class ProductWidgetSearch extends StatefulWidget {
  const ProductWidgetSearch({super.key});

  @override
  State<ProductWidgetSearch> createState() => _ProductWidgetSearchState();
}

class _ProductWidgetSearchState extends State<ProductWidgetSearch> {
  @override
  Widget build(BuildContext context) {
    final productModelProvider = Provider.of<ProductModel>(context);
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ProductDetailes.routeName);
        },
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: FancyShimmerImage(
                imageUrl: productModelProvider.productImage,
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
                    label: productModelProvider.productTitle,
                    maxLine: 2,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                const Flexible(
                  flex: 2,
                  child: CustomHeartButton(),
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
                    label: "\$${productModelProvider.productPrice}",
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
                      onTap: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.shopping_cart_checkout_sharp,
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
