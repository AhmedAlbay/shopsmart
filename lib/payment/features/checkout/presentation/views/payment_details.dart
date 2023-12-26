import 'package:flutter/material.dart';
import 'package:shopsmart_user/payment/core/widgets/custom_appbar.dart';
import 'package:shopsmart_user/payment/features/checkout/presentation/views/widgets/payment_details_view_body.dart';

class PaymentDetailsView extends StatelessWidget {
  const PaymentDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: "Payment Details"),
      body: const PaymentDetailsViewBody(),
    );
  }
}
