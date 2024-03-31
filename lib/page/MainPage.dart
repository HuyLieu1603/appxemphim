// ignore_for_file: unused_import, unnecessary_import, avoid_unnecessary_containers, file_names

import 'package:appxemphim/page/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _StateMainPageWidget();
}

class _StateMainPageWidget extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  'assets/images/MainPage/mainpage.png'), // se co update lay theo dia chi link
              alignment: Alignment.center,
              fit: BoxFit.fill)),
      child: Container(
        decoration: BoxDecoration(
            //border: Border.all(color: Colors.red,width: 2),
            gradient: LinearGradient(
          colors: [
            Colors.transparent.withOpacity(0.1),
            Colors.black.withOpacity(1)
          ],
          stops: const [0, 0.8],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 500),
              child: const Text(
                "Chương trình truyền hình,phim không giới hạn và nhiều nội dung khác",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: const Text(
                "Xem ở mọi nơi . Hủy bất kì lúc nào.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  decoration: TextDecoration.none,
                  fontFamily: "Montserrat",
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              width: double.maxFinite,
              height: 50,
              padding: const EdgeInsets.all(1),
              child: ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                  ),
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromRGBO(198, 10, 10, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Bắt đầu'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
