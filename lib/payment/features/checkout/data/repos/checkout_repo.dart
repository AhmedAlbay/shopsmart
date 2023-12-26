import 'package:dartz/dartz.dart';
import 'package:shopsmart_user/payment/core/errors/failure.dart';
import 'package:shopsmart_user/payment/features/checkout/data/model/payment_intent_input_model.dart';


abstract class CheckoutRepo {
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  });
}
