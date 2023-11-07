// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_user/providers/wishlist_provider.dart';
import 'package:shopsmart_user/services/my_app_method.dart';

class CustomHeartButton extends StatefulWidget {
  const CustomHeartButton(
      {super.key,
      this.size = 22,
      this.color,
      this.color1,
      required this.productId});
  final double size;
  final Color? color;
  final Color? color1;
  final String productId;
  @override
  State<CustomHeartButton> createState() => _CustomHeartButtonState();
}

class _CustomHeartButtonState extends State<CustomHeartButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final wishListProvider = Provider.of<WishListProvider>(context);
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.color,
      ),
      child: IconButton(
        style: IconButton.styleFrom(shape: const CircleBorder()),
        onPressed: () async {
          // wishListProvider.addOrRemoveProductToWishList(
          //     productId: widget.productId);
          setState(() {
            isLoading = true;
          });
          try {
            if (wishListProvider.getWishListItem
                .containsKey(widget.productId)) {
              await wishListProvider.removeItemWishListFromFirebase(
                wishListId:
                    wishListProvider.getWishListItem[widget.productId]!.id,
                productId: widget.productId,
              );
            } else {
              await wishListProvider.addWishListFirebase(
                  productId: widget.productId, context: context);
            }
            await wishListProvider.fetchWishList();
          } catch (error) {
            MyAppMethod.showErrowWariningDialog(
                context: context, subTitle: error.toString(), function: () {});
          } finally {
            if (mounted) {
              setState(() {
                isLoading = false;
              });
            }
          }
        },
        icon: isLoading
            ? const CircularProgressIndicator(
                color: Colors.red,
              )
            : Icon(
                wishListProvider.isProductInWishList(
                        productId: widget.productId)
                    ? IconlyBold.heart
                    : IconlyLight.heart,
                size: widget.size,
                color: wishListProvider.isProductInWishList(
                        productId: widget.productId)
                    ? Colors.red
                    : Colors.grey,
              ),
      ),
    );
  }
}
