// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers
import 'package:appxemphim/data/API/api.dart';
import 'package:appxemphim/page/naviFrame.dart';
import 'package:appxemphim/page/register.dart';
import 'package:flutter/material.dart';

void main() => runApp(const Login());

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thông tin không chính xác'),
          content: Text('Vui lòng kiểm tra lại tên người dùng và mật khẩu.'),
          actions: [
            TextButton(
              child: Text('Đóng'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  test() async {
    bool result = await APIResponsitory()
        .fetchdata(_usernameController.text, _passwordController.text);
    if (result) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NaviFrame(),
        ), // Thay SignUpScreen() bằng màn hình đăng ký người dùng của bạn
      );
    } else {
      showAlertDialog(context);
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() {
    // ignore: avoid_print
    print('Register method called'); // Thêm dòng này để in thông báo
    if (_formKey.currentState!.validate()) {
      // Perform registration logic here
      // ...
      // Registration successful
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Thông báo', textAlign: TextAlign.center),
            content: const Text(
              'Bạn đã đăng nhập thành công',
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NaviFrame(),
                    ),
                  );
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBar(
            backgroundColor: Colors.black,
            title: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 0,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/HUFLIX.png',
                    width: 130,
                    height: 80,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          color: Colors.black,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Tài khoản',
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 30.0),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Mời nhập tài khoản';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Mật khẩu',
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 30.0),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Mời nhập mật khẩu';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 50),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.grey, width: 2.0)),
                      child: Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: test,
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                            minimumSize: MaterialStateProperty.all(
                                const Size(double.infinity, 50)),
                          ),
                          child: const Text(
                            'Đăng Nhập',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Quên Mật Khẩu',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterWidget(),
                              ), // Thay SignUpScreen() bằng màn hình đăng ký người dùng của bạn
                            );
                          },
                          child: const Text(
                            'Chưa có tài khoản ? đăng ký ngay',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    // Container(
                    //   child: const Align(
                    //     alignment: Alignment.center,
                    //     child: Text(
                    //       'Sign in is protected by Google reCAPTCHA to ensure you’re not a bot.',
                    //       style: TextStyle(
                    //           color: Colors.white,
                    //           fontFamily: 'Arial',
                    //           fontSize: 13),
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   child: const Align(
                    //     alignment: Alignment.center,
                    //     child: Text(
                    //       'learn more',
                    //       style: TextStyle(color: Colors.white),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
