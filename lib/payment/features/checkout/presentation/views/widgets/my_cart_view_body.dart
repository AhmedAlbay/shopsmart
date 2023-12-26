import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_user/payment/core/widgets/custom_button.dart';
import 'package:shopsmart_user/payment/features/checkout/data/repos/checkout_repo_impl.dart';
import 'package:shopsmart_user/payment/features/checkout/presentation/manger/cubit/payment_cubit.dart';
import 'package:shopsmart_user/payment/features/checkout/presentation/views/widgets/order_info_item.dart';
import 'package:shopsmart_user/payment/features/checkout/presentation/views/widgets/payment_method_bottom_sheet.dart';
import 'package:shopsmart_user/payment/features/checkout/presentation/views/widgets/total_price.dart';
import 'package:shopsmart_user/providers/cart_provider.dart';
import 'package:shopsmart_user/providers/product_provider.dart';

class MyCartViewBody extends StatelessWidget {
  const MyCartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final String discount;
    final String shipping;
    final productProvider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    // double calculateFinalTotal(double totalPrice) {
    //   totalPrice = cartProvider.getTotal(productProvider: productProvider);
    //   double finalTotal = 0.0;
    //   double discount = 0.0;
    //   double shippingCost = 0.0;

    //   if (totalPrice > 5000) {
    //     // Apply a 20% discount for total price > 5000
    //     discount = 0.2 * totalPrice;
    //   }

    //   if (totalPrice > 500) {
    //     // Free shipping for total price > 500
    //     shippingCost = 0.0;
    //   } else {
    //     // Shipping cost of 45 for total price <= 500
    //     shippingCost = 45.0;
    //   }

    //   finalTotal = totalPrice - discount + shippingCost;

    //   return finalTotal;
    // }

    if (cartProvider.getTotal(productProvider: productProvider) > 5000 ||
        cartProvider.getTotal(productProvider: productProvider) > 500) {
      discount = '20%';
      shipping = r'0.0$';
    } else {
      discount = r'0.0$';
      shipping = r'45$';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 18,
          ),
          Expanded(child: Image.asset("assets/images/basket_image.png")),
          const SizedBox(
            height: 25,
          ),
          OrderInfoItem(
              title: "total Price",
              value:
                  '${cartProvider.getTotal(productProvider: productProvider)}\$'),
          const SizedBox(
            height: 5,
          ),
          OrderInfoItem(title: "Discount", value: discount),
          const SizedBox(
            height: 5,
          ),
          OrderInfoItem(title: "Shipping", value: shipping),
          const Divider(
            height: 34,
            color: Color(0xffC7C7C7),
            thickness: 2,
          ),
          TotalPrice(
              title: "Total",
              value:
                  '${(cartProvider.getTotal(productProvider: productProvider))}'),
          const SizedBox(
            height: 16,
          ),
          CustomButton(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  builder: (context) {
                    return BlocProvider(
                      create: (context) => PaymentCubit(CheckoutRepoImpl()),
                      child: const PaymentMethodBottomSheet(),
                    );
                  });
            },
            text: 'Complete Payment',
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
