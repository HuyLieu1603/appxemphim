import 'dart:convert';

import 'package:appxemphim/data/API/api.dart';
import 'package:appxemphim/data/model/accounts.dart';
import 'package:appxemphim/data/model/bank.dart';
import 'package:appxemphim/data/model/history/historyPurchase.dart';
import 'package:appxemphim/data/model/service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../history/purchase/historyPurchase.dart';

class PaymentWidget extends StatefulWidget {
  final Bank objBank;
  const PaymentWidget({Key? key, required this.objBank}) : super(key: key);

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  late Future<AccountsModel> _userInfoFuture;
  late Future<Service> _serviceInfoFuture;

  @override
  void initState() {
    super.initState();
    _userInfoFuture = getUserInfo();
    _serviceInfoFuture =
        _userInfoFuture.then((user) => _getServiceByUser(user));
  }

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

  Future<List<historyPurchase>> _pushPurchases() async {
    return await APIResponsitory().pushPurchase();
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
                'Thanh toán',
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
                  width: 150,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Image.network(
                  widget.objBank.img,
                  width: 75,
                  height: 75,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image),
                ),
                const SizedBox(width: 16),
                Text(
                  widget.objBank.name.toString().toUpperCase(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            // Widgets to display user info and service info
            FutureBuilder<AccountsModel>(
              future: _userInfoFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Placeholder for loading state
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tên người dùng: ${snapshot.data!.userName}',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Gói dịch vụ: ${snapshot.data!.serviceid}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  );
                }
              },
            ),
            SizedBox(height: 20),
            FutureBuilder<Service>(
              future: _serviceInfoFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Placeholder for loading state
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tên gói dịch vụ: ${utf8.decode(snapshot.data!.name.toString().codeUnits)}',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "Đơn giá: ${NumberFormat('###,###.### VNĐ').format(snapshot.data!.price)}",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  );
                }
              },
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
                              Text("thanh toán thành công!"),
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
