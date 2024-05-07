// ignore_for_file: use_build_context_synchronously, unused_import

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../../data/model/bank.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/const.dart';
import 'package:appxemphim/data/API/api.dart';
import '../../data/model/accounts.dart';
import '../../data/model/service.dart';

class ExtendServiceWidget extends StatefulWidget {
  final AccountsModel user;
  final Service service;
  const ExtendServiceWidget({super.key, required this.user, required this.service}) : super(key: key);

    @override
  State<ExtendServiceWidget> createState() => _ExtendServiceWidgetState();
}

class _ExtendServiceWidgetState extends State<ExtendServiceWidget> {

  Future<

  @override
  void initState() {
    super.initState;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: const Text(
                'Gia hạn gói tài khoản',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Màu của đường viền
                  width: 2, // Độ rộng của đường viền
                ),
                borderRadius: BorderRadius.circular(16), // Bo góc của hình ảnh
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: Image.asset(
                  'assets/images/HUFLIX.png',
                  width: 200,
                  height: 150
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Gói cơ bản", style: secondtitleStyle),
            const Text("VNĐ 180.000đ"),
            const Text("Total: VNĐ 180.000đ"),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 10.0),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11.0),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11.0),
                  borderSide: const BorderSide(
                    width: 1.0,
                    color: Colors.grey,
                  ),
                ),
                labelText: "Số thẻ",
                labelStyle: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 10.0),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11.0),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11.0),
                  borderSide: const BorderSide(
                    width: 1.0,
                    color: Colors.grey,
                  ),
                ),
                labelText: "Tên chủ thẻ",
                labelStyle: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 10.0),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11.0),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11.0),
                  borderSide: const BorderSide(
                    width: 1.0,
                    color: Colors.grey,
                  ),
                ),
                labelText: "Ngày hết hạn",
                labelStyle: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
                onPressed: () async {
                  // Gọi hàm để lưu lịch sử giao dịch
                  await _pushPurchases();
                  // Hiển thị dialog thông báo lưu thành công
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AlertDialog(
                        title: Text("Alert"),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text("Đã lưu thông tin thanh toán"),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                  // Chuyển hướng về trang chính sau khi lưu thành công
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const historyPurchaseWidget()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color.fromARGB(198, 198, 10, 10), // Màu nền của nút
                  foregroundColor: Colors.white, // Màu của text và icon
                  minimumSize:
                      const Size(300, 50), // Kích thước tối thiểu của nút
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)), // Bo góc
                ),
                child:
                    const Text('Thanh toán', style: TextStyle(fontSize: 20))),
          ],
        ),
      ),
    );
  }

  void _extendPackage(Duration duration) {
    DateTime newExpirationTime = DateTime.now().add(duration);
    onExtend(newExpirationTime);
  }

}
