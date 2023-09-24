import 'package:flutter/material.dart';
import 'package:shopsmart_user/widget/subtitle.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SubtitleTextWidget(
            label: "Aya",
            fontSize: 50,
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.italic,
            textDecoration: TextDecoration.underline,
            color: Colors.red,
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Hello world"),
          ),
          
        ],
      ),
    );
  }
}
