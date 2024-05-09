// ignore_for_file: unused_import

import 'dart:convert';
import 'package:appxemphim/data/model/register.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../page/banklist/banklistwidget.dart';
import 'momopaymentsandbox.dart';
import '../../config/const.dart';


class PaymentMethodWidget extends StatelessWidget {
  final String selectedServiceIds;
  final String? email;
  final String? password;
  final int? durationn;
  PaymentMethodWidget(
      {Key? key,
      required this.selectedServiceIds,
      this.email,
      this.password,
      this.durationn})
      : super(key: key);
  DateTime timenow = DateTime.now();
  void _onCreateAccountPressed() {
    if (email != null && password != null) {
      createAccount(email!, password!, selectedServiceIds, durationn!);
    }
  }

  Future<void> createAccount(String email, String password,
    String selectedServiceIds, int durationn) async {
    DateTime remain= timenow.add(Duration(days: durationn * 30));
    
    var url = Uri.parse(
        'https://662fcdce43b6a7dce310ccfe.mockapi.io/api/v1/account'); // Replace with the actual URL of the mockapi

    var signup = Signup(
      password: password,
      serviceid: selectedServiceIds,
      username: email,
      duration: remain,
    );

    var body = json.encode(signup.toJson());

    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      // Handle successful account creation
      print('Account created successfully');
    } else {
      // Handle errors
      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
          child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text("Chọn phương thức thanh toán", style: titleStyle),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                            "Chỉ cần vài bước là bạn sẽ hoàn tất!\nChúng tôi cũng chẳng thích thú gì với các loại giấy tờ",
                            style: backgroundtextStyle),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        createAccount(
                            email!, password!, selectedServiceIds, durationn!);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BankWidget()),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black, // Màu của text và icon
                        backgroundColor: Colors.white, // Màu nền của nút
                        fixedSize: const Size(75, 75),
                        side: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ), // Màu và độ rộng của viền
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16), // Bo góc
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Căn các phần tử theo từng cạnh của hàng
                        children: [
                          Row(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Thẻ ngân hàng nội địa',
                                  textAlign: TextAlign.left,
                                  style: textStyle,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Image.asset(
                                'assets/images/bank-logo-transparent-background.png',
                                width: 25,
                                height: 25,
                              ),
                            ],
                          ),
                          const Icon(
                              Icons.arrow_forward_ios), // Icon ở phía bên phải
                        ],
                      ),
                    ),
                    const SizedBox(height: 20), // Khoảng cách giữa các nút
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BankWidget()),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black, // Màu của text và icon
                        backgroundColor: Colors.white, // Màu nền của nút
                        fixedSize: const Size(75, 75),
                        side: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ), // Màu và độ rộng của viền
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16), // Bo góc
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Căn các phần tử theo từng cạnh của hàng
                        children: [
                          Row(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Ví điện tử',
                                  textAlign: TextAlign.left,
                                  style: textStyle,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Image.asset(
                                'assets/images/Logo-MoMo-Square.webp',
                                width: 25,
                                height: 25,
                              ),
                            ],
                          ),
                          const Icon(
                              Icons.arrow_forward_ios), // Icon ở phía bên phải
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        )
      ),
    );
  }
}
