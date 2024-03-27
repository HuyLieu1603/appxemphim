import 'package:flutter/material.dart';

void main() => runApp(const Registers());

class Registers extends StatefulWidget {
  const Registers({Key? key}) : super(key: key);

  @override
  _RegistersState createState() => _RegistersState();
}

class _RegistersState extends State<Registers> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  String password = '';
  String confirmPassword = '';

  @override
  void dispose() {
    _passwordController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {},
          ),
          centerTitle: true,
          title: Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Image.asset(
              'assets/images/HUFLIX.png',
              width: 200,
              height: 80,
            ),
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
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Chỉ cần vài bước là bạn sẽ hoàn tất!',
                      style: TextStyle(
                        color: Color.fromARGB(255, 100, 97, 97),
                        fontSize: 13,
                      ),
                    ),
                    const Text(
                      'Chúng tôi cũng chẳng hứng thú  gì với các loại giấy tờ',
                      style: TextStyle(
                        color: Color.fromARGB(255, 100, 97, 97),
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextFormField(
                        obscureText: true,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 30.0, horizontal: 10.0),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11.0),
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(255, 252, 252, 1),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11.0),
                            borderSide: const BorderSide(
                              width: 1.0,
                              color: Color.fromRGBO(255, 252, 252, 1),
                            ),
                          ),
                          labelText: "Mật khẩu",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Không được bỏ trống mật khẩu';
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
                        controller: _confirmpasswordController,
                        decoration: const InputDecoration(
                          labelText: 'Nhập lại mật khẩu',
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 30.0),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Không trùng khớp với mật khẩu';
                          } else if (value != password) {
                            return 'Mật khẩu không khớp';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 50),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(
                            2.0), // Điều chỉnh giá trị padding tùy ý
                        child: Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Hành động khi điều kiện thỏa mãn
                                // Ví dụ: Chuyển đến trang tiếp theo
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 198, 10, 10),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                minimumSize: (const Size(317, 46))),
                            child: const Text(
                              "Tiếp theo",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
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
}
