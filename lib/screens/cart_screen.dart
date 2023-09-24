import 'package:flutter/material.dart';
import 'package:shopsmart_user/widget/title.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: TitleTextWidget(
          label: 'Cart Screen',
          fontSize: 50,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.italic,
          textDecoration: TextDecoration.none,
          color: Colors.red,
        ),
      ),
    );
  }
}
