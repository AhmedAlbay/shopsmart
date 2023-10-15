import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_user/model/product_model.dart';
import 'package:shopsmart_user/providers/view_product_provider.dart';
import 'package:shopsmart_user/screens/inner_screen/product_detailes.dart';
import 'package:shopsmart_user/widget/product/custom_heart_button.dart';
import 'package:shopsmart_user/widget/title.dart';

class LastestArrivalProduct extends StatelessWidget {
  const LastestArrivalProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);
    final viewProduct = Provider.of<ViewProductProvider>(context);

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
                          const Icon(
                            Icons.shopping_cart_checkout_sharp,
                            size: 18,
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
