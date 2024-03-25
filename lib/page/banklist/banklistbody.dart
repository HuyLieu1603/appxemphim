import 'package:flutter/material.dart';
import '../../data/model/bankmodel.dart';
import '../../config/const.dart';

  // Create sub Widget
  Widget itemBankView(Bank bankModel){
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: Colors.white),
      child: Container(
        width: 150,
        height: 120,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15)
          //chỉnh radius theo mong muốn
        ),
        child: Image.asset(
          url_bank_img + bankModel.img!,
          fit: BoxFit.contain,
        ),
      ),
    );
  }