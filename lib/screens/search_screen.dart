import 'package:flutter/material.dart';
import 'package:shopsmart_user/widget/title.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: TitleTextWidget(
          label: 'Search Screen',
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
