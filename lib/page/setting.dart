// ignore_for_file: unused_import, camel_case_types, non_constant_identifier_names, sized_box_for_whitespace, avoid_unnecessary_containers, avoid_types_as_parameter_names

import 'package:appxemphim/page/banklist/banklistwidget.dart';
import 'package:appxemphim/page/favoriteMovie.dart';
import 'package:appxemphim/page/login.dart';
import 'package:appxemphim/page/naviFrame.dart';
import 'package:appxemphim/page/history/purchase/historyPurchase.dart';
import 'package:flutter/material.dart';
import '../data/model/account.dart';
import '../data/model/accounts.dart';
import '../data/provider/accountprovider.dart';
import '../config/const.dart';
import '../page/payment/extendservice.dart';
import '../data/API/api.dart';

class settingWidget extends StatefulWidget {
  const settingWidget({super.key});

  @override
  State<settingWidget> createState() => _settingWidgetState();
}

class _settingWidgetState extends State<settingWidget> {
  List<AccountModel> Accounts = [];

  @override
  void initState() {
    super.initState();
    Accounts = createDataList(5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          // leading: IconButton(
          //   icon: const Icon(Icons.arrow_back),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const NaviFrame(),
          //       ),
          //     );
          //   },
          // ),
          title: const Text(
            "Cài đặt",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            color: Colors.black,
            child: Column(
              children: [
                Container(
                  child: TextButton(
                    onPressed: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Thông tin cá nhân",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 360,
                      height: 46,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const historyPurchaseWidget(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(67, 60, 60, 1),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: (const Size(360, 57)),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Căn các phần tử theo từng cạnh của hàng
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Icon(Icons.history), // Icon
                                  SizedBox(
                                      width:
                                          10), // Khoảng cách giữa icon và text
                                  Text(
                                    'Lịch sử thanh toán',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ), // Text
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons
                                  .arrow_forward_ios), // Icon ở phía bên phải
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: 360,
                      height: 46,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const favoriteMovie(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(67, 60, 60, 1),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: (const Size(360, 57)),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Căn các phần tử theo từng cạnh của hàng
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Icon(Icons.list), // Icon
                                  SizedBox(
                                      width:
                                          10), // Khoảng cách giữa icon và text
                                  Text(
                                    'Danh sách yêu thích',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ), // Text
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons
                                  .arrow_forward_ios), // Icon ở phía bên phải
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: 360,
                      height: 46,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(67, 60, 60, 1),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: (const Size(360, 57)),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Căn các phần tử theo từng cạnh của hàng
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Icon(Icons.settings), // Icon
                                  SizedBox(
                                      width:
                                          10), // Khoảng cách giữa icon và text
                                  Text(
                                    'Cài đặt',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ), // Text
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons
                                  .arrow_forward_ios), // Icon ở phía bên phải
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: 360,
                      height: 46,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(67, 60, 60, 1),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: (const Size(360, 57)),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Căn các phần tử theo từng cạnh của hàng
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Icon(Icons.account_circle), // Icon
                                  SizedBox(
                                      width:
                                          10), // Khoảng cách giữa icon và text
                                  Text(
                                    'Tài khoản',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ), // Text
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons
                                  .arrow_forward_ios), // Icon ở phía bên phải
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: 360,
                      height: 46,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ExtendServiceWidget(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(67, 60, 60, 1),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: (const Size(360, 57)),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Căn các phần tử theo từng cạnh của hàng
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Icon(Icons.payment_outlined), // Icon
                                  SizedBox(
                                      width:
                                          10), // Khoảng cách giữa icon và text
                                  Text(
                                    'Gia hạn gói dịch vụ',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ), // Text
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons
                                  .arrow_forward_ios), // Icon ở phía bên phải
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: 360,
                      height: 46,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BankWidget(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(67, 60, 60, 1),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: (const Size(360, 57)),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Căn các phần tử theo từng cạnh của hàng
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Icon(Icons.payment_outlined), // Icon
                                  SizedBox(
                                      width:
                                          10), // Khoảng cách giữa icon và text
                                  Text(
                                    'Thanh toán',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ), // Text
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons
                                  .arrow_forward_ios), // Icon ở phía bên phải
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "ĐĂNG XUẤT",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 17,
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

Widget accountListView(AccountModel accountModel) {
  return Container(
    // grid without margin
    padding: const EdgeInsets.all(8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          url_img + accountModel.img!,
          height: 80,
          width: 80,
          errorBuilder: (context, error, StackTrace) => const Icon(Icons.image),
        ),
        Text(
          accountModel.userName ?? '',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}
