import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopsmart_user/widget/title.dart';

class AppNameText extends StatelessWidget {
  const AppNameText({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.purple,
        highlightColor: Colors.red,
        period: const Duration(seconds: 10),
        child: const TitleTextWidget(
          label: 'Shop Smart',
          fontSize: 20,
        ));
  }
}
