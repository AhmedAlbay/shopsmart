import 'package:dartz/dartz.dart';
import 'package:shopsmart_user/payment/core/errors/failure.dart';
import 'package:shopsmart_user/payment/core/utils/stripe_services.dart';
import 'package:shopsmart_user/payment/features/checkout/data/model/payment_intent_input_model.dart';
import 'package:shopsmart_user/payment/features/checkout/data/repos/checkout_repo.dart';


class CheckoutRepoImpl extends CheckoutRepo {
  final StripeServices stripeServices = StripeServices();
  @override
  Future<Either<Failure, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    try {
      await stripeServices.makePayment(
          paymentIntentInputModel: paymentIntentInputModel);
      return right(null);
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
