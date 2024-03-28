import 'package:appxemphim/page/payment/paymentwidget.dart';
import 'package:flutter/material.dart';
import '../../data/model/bankmodel.dart';
import '../../config/const.dart';

// Create sub Widget
Widget itemBankView(Bank itembank, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentWidget(
            objBank: itembank,
          ),
        ),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Image.asset(
        url_bank_img + itembank.img!,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.image),
      ),
    ),
  );
}