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
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Bạn đã sẵn sàng để xem chưa?",
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Nhập Email để tạo hoặc kích hoạt lại tư cách thành viên của bạn",
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 32,
            ),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 40.0, horizontal: 10.0),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11.0),
                  borderSide: const BorderSide(
                    color: Colors.green,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11.0),
                  borderSide: const BorderSide(
                    width: 5.0,
                    color: Colors.green,
                  ),
                ),
                labelText: "Email",
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(198, 198, 10, 10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: (const Size(370, 40))),
              child: const Text(
                "Bắt đầu",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
