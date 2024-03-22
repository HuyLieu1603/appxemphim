import 'package:appxemphim/data/model/service.dart';
import 'package:flutter/material.dart';
import 'page/logo.dart';
import 'page/servicewidget.dart';
import 'page/MainPage.dart';
import 'page/register.dart';
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LogoPage(),
    );
  }
}
