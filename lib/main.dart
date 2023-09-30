import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_user/providers/theme_provider.dart';
import 'package:shopsmart_user/root_screen.dart';
import 'package:shopsmart_user/screens/cart/cart_screen.dart';
import 'package:shopsmart_user/screens/inner_screen/product_detailes.dart';
import 'package:shopsmart_user/screens/inner_screen/viewed_recent.dart';
import 'package:shopsmart_user/screens/inner_screen/wishlist_screen.dart';

import 'consts/theme_data.dart';

void main() {
  runApp(const ShopSmart());
}

class ShopSmart extends StatelessWidget {
  const ShopSmart({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(builder: (
        context,
        themeProvider,
        child,
      ) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Shop Smart AR',
            theme: Styles.themeData(
                isDarkTheme: themeProvider.getIsDarkTheme, context: context),
            home: const RootScreen(),
            routes: {
              ProductDetailes.routeName: (context) => const ProductDetailes(),
              CartScreen.routeName: (context) => const CartScreen(),
              WishListScreen.routeName: (context) => const WishListScreen(),
              ViewedRecentScreen.routeName: (context) =>
                  const ViewedRecentScreen(),
            });
      }),
    );
  }
}
