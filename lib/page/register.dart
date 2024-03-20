import 'package:appxemphim/config/const.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: const Column(
          children: [
            Text(
              "Bạn đã sẵn sàng để xem chưa?",
              style: titleStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
                "Nhập Email để tạo hoặc kích hoạt lại tư cách thành viên của bạn"),
          ],
        ),
      ),
    );
  }
}
