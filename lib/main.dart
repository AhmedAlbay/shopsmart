import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_user/auth/forget_password_screen.dart';
import 'package:shopsmart_user/auth/login_screen.dart';
import 'package:shopsmart_user/auth/register_screen.dart';
import 'package:shopsmart_user/providers/cart_provider.dart';
import 'package:shopsmart_user/providers/product_provider.dart';
import 'package:shopsmart_user/providers/theme_provider.dart';
import 'package:shopsmart_user/providers/wishlist_provider.dart';
import 'package:shopsmart_user/root_screen.dart';
import 'package:shopsmart_user/screens/cart/cart_screen.dart';
import 'package:shopsmart_user/screens/inner_screen/product_detailes.dart';
import 'package:shopsmart_user/screens/inner_screen/viewed_recent.dart';
import 'package:shopsmart_user/screens/inner_screen/wishlist_screen.dart';
import 'package:shopsmart_user/screens/order/order_screen.dart';
import 'package:shopsmart_user/screens/search_screen.dart';

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
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),     ChangeNotifierProvider(
          create: (_) => WishListProvider(),
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
              RegisterScreen.routeName: (context) => const RegisterScreen(),
              LoginScreen.routeName: (context) => const LoginScreen(),
              OrderScreen.routeName: (context) => const OrderScreen(),
              ForgetPasswordScreen.routeName: (context) =>
                  const ForgetPasswordScreen(),
              SearchScreen.routeName: (context) => const SearchScreen(),
            });
      }),
    );
  }
}
