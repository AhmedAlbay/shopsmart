// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shopsmart_user/payment/core/utils/api_key.dart';
import 'package:shopsmart_user/payment/core/utils/api_service.dart';
import 'package:shopsmart_user/payment/features/checkout/data/model/ephemeral_key_model/ephemeral_key_model.dart';
import 'package:shopsmart_user/payment/features/checkout/data/model/init_payment_sheet_model.dart';
import 'package:shopsmart_user/payment/features/checkout/data/model/payment_intent_input_model.dart';
import 'package:shopsmart_user/payment/features/checkout/data/model/payment_intent_model/payment_intent_model.dart';


class StripeServices {
  final ApiServices apiServices = ApiServices();

  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    try {
      var response = await apiServices.post(
        url: 'https://api.stripe.com/v1/payment_intents',
        body: paymentIntentInputModel.toJson(),
        contentType: Headers.formUrlEncodedContentType,
        token: ApiKey.secretKey,
      );

      var paymentInputModel = PaymentIntentModel.fromJson(response.data);
      return paymentInputModel;
    } catch (e) {
      // Handle errors appropriately
      print('Error creating payment intent: $e');
      throw Exception('Failed to create payment intent');
    }
  }

  Future initPaymentSheet(
      {required InitPaymentSheetModel initPaymentSheetModel}) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: initPaymentSheetModel.clientSecret,
          customerEphemeralKeySecret: initPaymentSheetModel.ephmeralKey,
          customerId: initPaymentSheetModel.customerId,
          merchantDisplayName: 'Ahmed',
        ),
      );
    } catch (e) {
      print('Error initializing payment sheet: $e');
      throw Exception('Failed to initialize payment sheet');
    }
  }

  Future displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      print('Error displaying payment sheet: $e');
      throw Exception('Failed to display payment sheet');
    }
  }

  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    try {
      var paymentInputModel =
          await createPaymentIntent(paymentIntentInputModel);
      var ehpmeralKeyModel =
          await createEphemeralKey(customerId: paymentInputModel.customer);
      var initPaymentSheetModel = InitPaymentSheetModel(
          clientSecret: paymentInputModel.clientSecret!,
          ephmeralKey: ehpmeralKeyModel.secret!,
          customerId: paymentInputModel.customer);

      await initPaymentSheet(initPaymentSheetModel: initPaymentSheetModel);
      await displayPaymentSheet();
    } catch (e) {
      print('Error making payment: $e');
      throw Exception('Failed to make payment');
    }
  }

  Future<EphemeralKeyModel> createEphemeralKey(
      {required String customerId}) async {
    try {
      var response = await apiServices.post(
        url: 'https://api.stripe.com/v1/ephemeral_keys',
        body: {'customer': customerId},
        contentType: Headers.formUrlEncodedContentType,
        token: ApiKey.secretKey,
        headers: {
          'Authorization': "Bearer ${ApiKey.secretKey}",
          'Stripe-Version': '2023-10-16',
        },
      );

      var ephemeralKey = EphemeralKeyModel.fromJson(response.data);
      return ephemeralKey;
    } catch (e) {
      print('Error creating ephemeral key: $e');
      throw Exception('Failed to create ephemeral key');
    }
  }
}
