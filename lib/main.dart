import 'package:flutter/material.dart';
import 'page/logo.dart';
import 'page/servicewidget.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ServiceWidget(),
    );
  }
}
