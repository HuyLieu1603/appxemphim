import 'dart:async';

import 'package:appxemphim/page/MainPage.dart';
import 'package:flutter/material.dart';

class LogoPage extends StatefulWidget {
  const LogoPage({super.key});

  @override
  State<LogoPage> createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration:
              const Duration(milliseconds: 500), // Độ dài của hiệu ứng
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return ScaleTransition(
              // Sử dụng ScaleTransition để tạo hiệu ứng xuất hiện từ trung tâm
              scale: Tween<double>(
                begin: 0.0, // Bắt đầu từ kích thước ẩn (0.0)
                end: 1.0, // Kết thúc ở kích thước đầy đủ (1.0)
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              )),
              child: child,
            );
          },
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return const MainPage(); // Màn hình mới sau khi đổi
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/HUFLIX.png',
              width: 350,
            ),
          ],
        ),
      ),
    );
  }
}
