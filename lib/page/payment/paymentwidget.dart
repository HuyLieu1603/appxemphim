import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../../data/model/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/const.dart';

class PaymentWidget extends StatefulWidget {
  const PaymentWidget({super.key});

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  final _sothe = TextEditingController();
  final _tenchuthe = TextEditingController();
  final _ngayphathanh = TextEditingController();

  // get user
  getUser() {
    var sothe = _sothe.text;
    var tenchuthe = _tenchuthe.text;
    var ngayphathanh = _ngayphathanh.text;

    //create class
    var objUser = User(sothe: sothe, tenchuthe: tenchuthe, ngayphathanh: ngayphathanh);
    return objUser;
  }

  //Save user to shared_preferences
  Future<bool> saveUser(User objUser) async{
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
  Widget build(BuildContext context){
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
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
                Image.asset(
                  'assets/images/HUFLIX.png',
                  width: 150,
                ),
                const SizedBox(height: 16),
                const Text("Gói cơ bản", style: secondtitleStyle),
                const Text("VNĐ 180.000đ"),
                const Text("Total: VNĐ 180.000đ"),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 25.0, horizontal: 10.0),
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
                    labelStyle: const TextStyle(color: Colors.grey,),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 25.0, horizontal: 10.0),
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
                    labelStyle: const TextStyle(color: Colors.grey,),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 25.0, horizontal: 10.0),
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
                    labelText: "Ngày phát hành",
                    labelStyle: const TextStyle(color: Colors.grey,),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    //get value
                    var objUser = getUser();
                    //save to Share preferences
                    if (await saveUser(objUser) == true){
                      if (kDebugMode) {
                        print(objUser.toJson());
                      }
                      showDialog(
                        context: context,
                        builder: (BuildContext context){
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
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Màu nền của nút
                    foregroundColor: Colors.white, // Màu của text và icon
                    minimumSize: const Size(200, 50), // Kích thước tối thiểu của nút
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)), // Bo góc
                  ),
                  child: const Text('Thanh toán', style: TextStyle(fontSize: 20))
                ),
              ],
            ),
          ),
        ),
      );
  }
}