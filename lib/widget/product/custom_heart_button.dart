import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_user/providers/wishlist_provider.dart';

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
        onPressed: () {
          wishListProvider.addOrRemoveProductToWishList(
              productId: widget.productId);
        },
        icon: Icon(
          wishListProvider.isProductInWishList(
              productId: widget.productId)?IconlyBold.heart :
          IconlyLight.heart,
          size: widget.size,
          color:wishListProvider.isProductInWishList(
              productId: widget.productId)? Colors.red :Colors.grey ,
        ),
      ),
    );
  }
}
