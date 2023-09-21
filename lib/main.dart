import 'package:flutter/material.dart';
import 'package:shopsmart_user/const/app_theme.dart';
import 'package:shopsmart_user/screens/home_screen.dart';

void main() {
  runApp(const ShopSmart());
}

class ShopSmart extends StatelessWidget {
  const ShopSmart({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop Smart',
      theme: Styles.themeData(isDarkTheme: false, context: context),
      home: const HomeScreen(),
    );
  }
}
