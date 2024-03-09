import 'package:flutter/material.dart';
import '../config/const.dart';

class logoPage extends StatelessWidget {
  const logoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/HUFLIX.png',
                width:300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
