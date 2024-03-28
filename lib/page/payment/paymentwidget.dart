// ignore_for_file: use_build_context_synchronously

import 'package:appxemphim/page/login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../../data/model/usermodel.dart';
import '../../data/model/bankmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/const.dart';

class PaymentWidget extends StatefulWidget {
  final Bank objBank;
  const PaymentWidget({Key? key, required this.objBank}) : super(key: key);

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  @override
  void initState() {
    super.initState;
  }

  final _sothe = TextEditingController();
  final _tenchuthe = TextEditingController();
  final _ngayphathanh = TextEditingController();

  // get user
  getUser() {
    var sothe = _sothe.text;
    var tenchuthe = _tenchuthe.text;
    var ngayphathanh = _ngayphathanh.text;

    //create class
    var objUser =
        User(sothe: sothe, tenchuthe: tenchuthe, ngayphathanh: ngayphathanh);
    return objUser;
  }

  //Save user to shared_preferences
  Future<bool> saveUser(User objUser) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String strUser = jsonEncode(objUser);
      prefs.setString('user', strUser);
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
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
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
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
                  borderRadius:
                      BorderRadius.circular(16), // Bo góc của hình ảnh
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Gói cơ bản", style: secondtitleStyle),
            const Text("VNĐ 180.000đ"),
            const Text("Total: VNĐ 180.000đ"),
            const SizedBox(height: 16),
            Row(
              children: [
                Image.asset(
                  url_bank_img + widget.objBank.img!,
                  width: 75,
                  height: 75,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image),
                ),
                const SizedBox(width: 16),
                Text(widget.objBank.name.toString().toUpperCase(), 
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
              ],
            ),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 10.0),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11.0),
                  borderSide: const BorderSide(
                    color: Colors.black,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: Image.asset(
                    'assets/images/HUFLIX.png',
                    width: 150,
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
                    //get value
                    var objUser = getUser();
                    //save to Share preferences
                    if (await saveUser(objUser) == true) {
                      if (kDebugMode) {
                        print(objUser.toJson());
                      }
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
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Màu nền của nút
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
      ),
    );
  }
}
