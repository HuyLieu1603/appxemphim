// ignore_for_file: unused_import, duplicate_import

import 'package:appxemphim/data/model/service.dart';
import 'package:appxemphim/page/login.dart';
import 'package:appxemphim/page/optionalaccount.dart';
import 'package:appxemphim/page/paymentmethod/paymentmethodwidget.dart';
import 'package:appxemphim/page/registers.dart';
import 'package:appxemphim/page/setting.dart';
import 'package:flutter/material.dart';
import 'page/logo.dart';
import 'page/servicewidget.dart';
import 'page/MainPage.dart';
import 'page/NaviFrame.dart';
import 'page/register.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaymentMethodWidget(),
    );
  }
}
