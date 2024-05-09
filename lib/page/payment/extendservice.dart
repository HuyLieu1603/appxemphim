// ignore_for_file: use_build_context_synchronously, unused_import

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../../data/model/bank.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/const.dart';
import 'package:appxemphim/data/API/api.dart';
import '../../data/model/accounts.dart';
import '../../data/model/history/historyPurchase.dart';
import '../../data/model/service.dart';
import '../history/purchase/historyPurchase.dart';

class ExtendServiceWidget extends StatefulWidget {
  const ExtendServiceWidget({Key? key}) : super(key: key);

  @override
  State<ExtendServiceWidget> createState() => _ExtendServiceWidgetState();
}

class _ExtendServiceWidgetState extends State<ExtendServiceWidget> {
  late AccountsModel user;
  late Service? serv;
  Future<void> _getServiceByUser(AccountsModel user) async {
    final String accountId = user.idaccount;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Service? service = await APIResponsitory().getServiceByUser(
        accountId,
        prefs.getString('name').toString(),
        prefs.getString('price').toString());
    setState(() {
      serv = service;
    });
  }

// Hàm để tính toán ngày hết hạn mới dựa trên lựa chọn
  DateTime calculateNewExpiryDate(String option, DateTime currentExpiry) {
    int monthsToAdd;
    switch (option) {
      case '1 tháng':
        monthsToAdd = 1;
        break;
      case '3 tháng':
        monthsToAdd = 3;
        break;
      case '6 tháng':
        monthsToAdd = 6;
        break;
      case '1 năm':
        monthsToAdd = 12;
        break;
      default:
        monthsToAdd = 0;
    }
    return DateTime(currentExpiry.year, currentExpiry.month + monthsToAdd,
        currentExpiry.day);
  }

  Future<List<historyPurchase>> _pushPurchases() async {
    return await APIResponsitory().pushPurchase();
  }

  @override
  void initState() {
    super.initState();
    _getServiceByUser(user);
  }

  @override
  Widget build(BuildContext context) {
    // Danh sách các lựa chọn gia hạn
    List<String> extendOptions = ['1 tháng', '3 tháng', '6 tháng', '1 năm'];
    String selectedOption = extendOptions.first; // Lựa chọn mặc định
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
                child: Image.asset('assets/images/HUFLIX.png',
                    width: 200, height: 150),
              ),
            ),
            const SizedBox(height: 20),
            Text(serv?.name ?? '', style: secondtitleStyle),
            Text(serv?.price ?? ''),
            // Widget DropdownButton để chọn lựa chọn gia hạn
            DropdownButton<String>(
              value: selectedOption,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  selectedOption = newValue!;
                  // Cập nhật ngày hết hạn mới dựa trên lựa chọn
                });
              },
              items: extendOptions.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () async {
                  // Gọi hàm để lưu lịch sử giao dịch
                  await _pushPurchases();
                  user.duration = calculateNewExpiryDate(selectedOption, user.duration);
                  // Hiển thị dialog thông báo lưu thành công
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AlertDialog(
                        title: Text("Alert"),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text("Đã gia hạn gói dịch vụ"),
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
}
