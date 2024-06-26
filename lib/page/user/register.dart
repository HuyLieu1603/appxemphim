import 'package:appxemphim/page/user/registers.dart';
import 'package:flutter/material.dart';

class RegisterWidget extends StatefulWidget {
  RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  String email = '';

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
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            const Text(
              "Bạn đã sẵn sàng để xem chưa?",
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Nhập Email để tạo hoặc kích hoạt lại tư cách thành viên của bạn",
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 32,
            ),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 25.0, horizontal: 10.0),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11.0),
                  borderSide: const BorderSide(
                    color: Colors.green,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11.0),
                  borderSide: const BorderSide(
                    width: 1.0,
                    color: Colors.green,
                  ),
                ),
                labelText: "Email",
              ),
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            const SizedBox(
              height: 18,
            ),
            ElevatedButton(
              onPressed: () {
                if (email.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Registers(Email: email),
                    ),
                  );
                } else {
                  // Hiển thị thông báo lỗi hoặc thực hiện hành động khác khi email trống
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Lỗi'),
                      content: const Text('Vui lòng nhập địa chỉ email.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Đóng'),
                        ),
                      ],
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(198, 198, 10, 10),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(370, 40),
              ),
              child: const Text(
                "Tiếp theo",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
      )
    );
  }
}
