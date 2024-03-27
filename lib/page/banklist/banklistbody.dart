import 'package:flutter/material.dart';
import '../../data/model/bankmodel.dart';
import '../../config/const.dart';

  // Create sub Widget
  Widget itemBankView(Bank bankModel){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset(
          url_bank_img + bankModel.img!,
          height: 87,
          width: 100,
          errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.image),
      ),
    );
  }