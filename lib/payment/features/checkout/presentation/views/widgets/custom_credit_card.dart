// import 'package:flutter/material.dart';
// import 'package:flutter_credit_card/flutter_credit_card.dart';

// class CustomCreditCard extends StatefulWidget {
//   const CustomCreditCard(
//       {super.key, required this.autovalidateMode, required this.formKey});
//   final AutovalidateMode autovalidateMode;
//   final GlobalKey<FormState> formKey;

//   @override
//   State<CustomCreditCard> createState() => _CustomCreditCardState();
// }

// class _CustomCreditCardState extends State<CustomCreditCard> {
//   String cardNumber = '', expiryDate = '', cardHolderName = '', cvvCode = '';
//   bool showBackView = false;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CreditCardWidget(
//             cardNumber: cardNumber,
//             expiryDate: expiryDate,
//             cardHolderName: cardHolderName,
//             cvvCode: cvvCode,
//             showBackView: showBackView,
//             isHolderNameVisible: true,
//             onCreditCardWidgetChange: (value) {}),
//         CreditCardForm(
//             autovalidateMode: widget.autovalidateMode,
//             cardNumber: cardNumber,
//             expiryDate: expiryDate,
//             cardHolderName: cardHolderName,
//             cvvCode: cvvCode,
//             onCreditCardModelChange: (creditCardModel) {
//               cardNumber = creditCardModel.cardNumber;
//               expiryDate = creditCardModel.expiryDate;
//               cardHolderName = creditCardModel.cardHolderName;
//               showBackView = creditCardModel.isCvvFocused;
//               cvvCode = creditCardModel.cvvCode;
//               setState(() {});
//             },
//             formKey: widget.formKey)
//       ],
//     );
//   }
// }
