
import 'package:flutter/material.dart';
import 'package:shopsmart_user/widget/subtitle.dart';

class QuantityBottomSheet extends StatelessWidget {
  const QuantityBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          width: 60,
          height: 6,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32), color: Colors.grey),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: 30,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {},
                    child: GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Center(
                            child: SubtitleTextWidget(label: '${index + 1}')),
                      ),
                    ));
              }),
        ),
      ],
    );
  }
}
