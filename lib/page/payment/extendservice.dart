// ignore_for_file: use_build_context_synchronously, unused_import

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  List<String> extendOptions = ['1 tháng', '3 tháng', '6 tháng', '12 tháng'];
  int selectedOption = 1; // Lựa chọn mặc định

  Future<AccountsModel> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime duration = DateTime.parse(prefs.getString('duration') ?? '0');
    return await APIResponsitory().getUserInfo(
        prefs.getString('name').toString(),
        prefs.getString('serviceid').toString(),
        duration,
        prefs.getString('idaccount').toString());
  }

  Future<Service> _getServiceByUser(AccountsModel user) async {
    final String serviceId = user.serviceid;
    print(serviceId);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await APIResponsitory().getServiceByUser(
        serviceId,
        prefs.getString('servicename').toString(),
        prefs.getString('serviceprice').toString(),
        prefs.getString('serviceimg').toString());
  }

  Future<void> _getUserInfoAndService() async {
    AccountsModel user = await getUserInfo();
    _getServiceByUser(user);
  }

// Hàm để tính toán ngày hết hạn mới dựa trên lựa chọn
  DateTime calculateNewExpiryDate(int option, DateTime currentExpiry) {
    return currentExpiry.add(Duration(days: option * 30));
  }

  Future<void> _ExtendedService(String idAccount, DateTime duration) async {
    return await APIResponsitory().extendService(idAccount, duration);
  }

  @override
  void initState() {
    super.initState();
    _getUserInfoAndService();
  }

  // Hàm để lấy con số từ chuỗi lựa chọn
  int extractMonths(String option) {
    final RegExp regex = RegExp(r'(\d+) tháng');
    final match = regex.firstMatch(option);
    if (match != null) {
      return int.parse(match.group(1)!);
    } else {
      // Trường hợp không tìm thấy con số, mặc định trả về 1
      return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
     final screenSize = MediaQuery.of(context).size;
    return FutureBuilder<AccountsModel?>(
      future: getUserInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
         return Container(
                height: screenSize.height,
                width: screenSize.width,
                decoration: BoxDecoration(color: Colors.black),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ); // Hiển thị loading indicator khi đang chờ
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // Hiển thị lỗi nếu có
        } else if (snapshot.hasData) {
          AccountsModel? user = snapshot.data;
          return FutureBuilder<Service>(
            future: _getServiceByUser(user!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
               return Container(
                height: screenSize.height,
                width: screenSize.width,
                decoration: BoxDecoration(color: Colors.black),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ); 
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                Service? serv = snapshot.data;
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
                            borderRadius: BorderRadius.circular(
                                16), // Bo góc của hình ảnh
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Container(
                            // padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                            child: Image.network(
                              serv!.img,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.image),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(utf8.decode(serv.name.toString().codeUnits),
                            style: secondtitleStyle),
                        Text(
                            "Đơn giá: ${NumberFormat('###,###.### VNĐ').format(serv.price)}"),
                        Text(
                          "Tổng tiền: ${NumberFormat('###,###.### VNĐ').format(serv.price * selectedOption)}",
                          style:
                              const TextStyle(fontSize: 20, color: Colors.red),
                        ),
                        // Widget DropdownButton để chọn lựa chọn gia hạn
                        DropdownButton<int>(
                          value: selectedOption,
                          onChanged: (int? newValue) {
                            if (newValue != null) {
                              setState(() {
                                selectedOption = newValue;
                              });
                            }
                          },
                          items: extendOptions.map((String value) {
                            return DropdownMenuItem<int>(
                              value: extractMonths(
                                  value), // Chuyển đổi từ chuỗi sang số nguyên
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () async {
                            await _ExtendedService(user.idaccount,
                                user.duration); // Đợi cho phương thức hoàn thành
                            // Hiển thị dialog thông báo lưu thành công
                            // Tính toán và cập nhật duration
                            DateTime newDuration = calculateNewExpiryDate(
                                selectedOption, user.duration);
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString(
                                'duration', newDuration.toIso8601String());
                            user.duration = newDuration;
                            // Gọi hàm để lưu lịch sử giao dịch
                            print(user.duration);
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
                                builder: (context) =>
                                    const historyPurchaseWidget(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                                198, 198, 10, 10), // Màu nền của nút
                            foregroundColor:
                                Colors.white, // Màu của text và icon
                            minimumSize: const Size(
                                300, 50), // Kích thước tối thiểu của nút
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10)), // Bo góc
                          ),
                          child: const Text('Thanh toán',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Text(
                    'No data found'); // Hiển thị thông báo nếu không có dữ liệu
              }
            },
          );
        } else {
          return const Text(
              'No data found'); // Hiển thị thông báo nếu không có dữ liệu
        }
      },
    );
  }
}
