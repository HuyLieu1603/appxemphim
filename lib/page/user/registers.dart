// ignore_for_file: avoid_unnecessary_containers, body_might_complete_normally_nullable

import 'package:appxemphim/page/servicewidget.dart';
import 'package:flutter/material.dart';

class Registers extends StatefulWidget {
  final String? Email;

  Registers({Key? key, this.Email = ''})
      : super(key: key ?? ValueKey('Registers'));
  @override
  State<Registers> createState() => _RegistersState();
}

class _RegistersState extends State<Registers> {
  bool _isPasswordEmpty = false;
  String _passwordErrorMessage = '';
  bool _isConfirmPasswordEmpty = false;
  String _confirmPasswordMessage = '';
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
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
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 90),
                    const Text(
                      'Tạo mật khẩu để bắt đầu với tư cách thành viên',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                      // textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Chỉ cần vài bước là bạn sẽ hoàn tất ',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    const Text(
                      'Chúng tôi cũng chẳng hứng thú  gì với các loại giấy tờ',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                        border: _isPasswordEmpty
                            ? Border.all(color: Colors.red)
                            : null,
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Mật Khẩu',
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 30.0),
                        ),
                        obscureText: true,
                        validator: (value) => _validatePassword(value),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (_isPasswordEmpty && _passwordErrorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 16.0,
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              _passwordErrorMessage,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    // const SizedBox(height: 16),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                        border: _isPasswordEmpty
                            ? Border.all(color: Colors.red)
                            : null,
                      ),
                      child: TextFormField(
                        controller: _confirmpasswordController,
                        decoration: const InputDecoration(
                          labelText: 'Nhập lại mật khẩu',
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 30.0),
                        ),
                        obscureText: true,
                        validator: (value) => _validateConfirmPassword(value!),
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (_isConfirmPasswordEmpty &&
                        _confirmPasswordMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Row(
                          children: [
                            const SizedBox(height: 20),
                            const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 16.0,
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              _confirmPasswordMessage,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(
                            2.0), // Điều chỉnh giá trị padding tùy ý
                        child: Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              String? email = widget.Email;
                              String? password = _passwordController.text;

                              if (_formKey.currentState!.validate()) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ServiceWidget(
                                        email: email, password: password),
                                  ),
                                );
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(198, 198, 10, 10),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Đặt border radius ở đây
                                ),
                              ),
                              minimumSize: MaterialStateProperty.all(
                                  const Size(double.infinity, 50)),
                            ),
                            child: const Text(
                              'Tiếp theo',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _validatePassword(String? passwordConfirmation) {
    final password = _passwordController.text;

    if (password.isEmpty || passwordConfirmation!.isEmpty) {
      setState(() {
        _isPasswordEmpty = true;
        _passwordErrorMessage = '';
      });
      return 'Không được để trống';
    }

    if (password != passwordConfirmation) {
      setState(() {
        _isPasswordEmpty = false;
        _passwordErrorMessage = 'Mật khẩu không trùng';
      });
      return 'Mật khẩu không trùng';
    }

    setState(() {
      _isPasswordEmpty = false;
      _passwordErrorMessage = '';
    });

    return null;
  }

  String? _validateConfirmPassword(String passwordConfirmation) {
    final password = _passwordController.text;
    final confirmPassword = _confirmpasswordController.text;

    if (confirmPassword.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        _isConfirmPasswordEmpty = true;
        _confirmPasswordMessage = '';
      });
      return 'Không được để trống';
    }

    if (confirmPassword != password) {
      setState(() {
        _isConfirmPasswordEmpty = true;
        _confirmPasswordMessage = 'Mật khẩu không trùng';
      });
      return 'Mật khẩu không trùng';
    }

    setState(() {
      _isConfirmPasswordEmpty = false;
      _confirmPasswordMessage = '';
    });

    return null;
  }
}
