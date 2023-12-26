class InitPaymentSheetModel {
  final String clientSecret;
  final String ephmeralKey;
  final String customerId;

  InitPaymentSheetModel({
    required this.clientSecret,
    required this.ephmeralKey,
    required this.customerId,
  });
}
