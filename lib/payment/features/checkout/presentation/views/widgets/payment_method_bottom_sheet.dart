import 'package:flutter/material.dart';
import 'package:shopsmart_user/payment/features/checkout/presentation/views/widgets/custom_buttom_bloc_consumer.dart';
import 'package:shopsmart_user/payment/features/checkout/presentation/views/widgets/payment_methods_list_view.dart';

class PaymentMethodBottomSheet extends StatelessWidget {
  const PaymentMethodBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 16,
          ),
          PaymentMethodsListView(),
          SizedBox(
            height: 32,
          ),
          CustomButtomBlocConsumer()
        ],
      ),
    );
  }
}
