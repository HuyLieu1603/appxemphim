import 'package:flutter/material.dart';
import '../../config/const.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Home Page",
        style: titleStyle,
      ),
    );
  }
}