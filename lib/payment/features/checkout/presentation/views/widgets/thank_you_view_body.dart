import 'package:flutter/material.dart';
import 'package:shopsmart_user/payment/features/checkout/presentation/views/widgets/custom_check_icon_card.dart';
import 'package:shopsmart_user/payment/features/checkout/presentation/views/widgets/custom_dash_line.dart';
import 'package:shopsmart_user/payment/features/checkout/presentation/views/widgets/custom_thank_you_card.dart';

class ThankYouViewBody extends StatelessWidget {
  const ThankYouViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Stack(clipBehavior: Clip.none, children: [
        const CustomThankYouCard(),
        Positioned(
          bottom: MediaQuery.sizeOf(context).height * .2 + 20,
          right: 16 + 20,
          left: 16 + 20,
          child: const CustomDashLine(),
        ),
        Positioned(
            left: -20,
            bottom: MediaQuery.sizeOf(context).height * .2,
            child: const CircleAvatar(
              backgroundColor: Colors.white,
            )),
        Positioned(
            right: -20,
            bottom: MediaQuery.sizeOf(context).height * .2,
            child: const CircleAvatar(
              backgroundColor: Colors.white,
            )),
        const Positioned(
          top: -50,
          left: 0,
          right: 0,
          child: CustomCheckIconCard(),
        )
      ]),
    );
  }
}
