import 'package:appxemphim/page/payment/paymentwidget.dart';
import 'package:flutter/material.dart';
import '../../data/model/bankmodel.dart';
import '../../config/const.dart';

// Create sub Widget
Widget itemBankView(Bank bankModel) {
  return Builder(
    builder: (context) => Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextButton(
          onPressed: () {
            // Điều hướng sang màn hình chi tiết ngân hàng khi nút được nhấn
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) =>const  PaymentWidget()),
            );
          },
          child: Image.asset(
            url_bank_img + bankModel.img!,
            errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.image),
          ),
        ),
    ),
  );
}
