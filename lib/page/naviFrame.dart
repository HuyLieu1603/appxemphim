// ignore_for_file: unused_import, unused_field, constant_identifier_names, prefer_interpolation_to_compose_strings, file_names

import 'package:appxemphim/page/Detailwidget/menumoviewidget.dart';
import 'package:appxemphim/page/Detailwidget/searchmoviewidget.dart';
import 'package:appxemphim/page/history/Movie/historyMovie.dart';
import 'package:appxemphim/page/logo.dart';
import 'package:appxemphim/page/optionalaccount.dart';
import 'package:appxemphim/page/setting.dart';
import 'package:flutter/material.dart';
import '../config/const.dart';

class NaviFrame extends StatefulWidget {
  const NaviFrame({Key? key}) : super(key: key);

  @override
  State<NaviFrame> createState() => _NaviFrameState();
}

class _NaviFrameState extends State<NaviFrame> {
  int _selectIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _WidgetOptions = <Widget>[
    Menumoviewidget(),
    Searchmoviewidget(),
    historyMovie(),
    settingWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text(
            "For you",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          leading: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 30,
                margin: const EdgeInsets.only(right: 10),
                child: Image.asset(
                  url_img + "H.png",
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          actions: [
            // mai mot no se la nut
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OptionalAccount(),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                child: Image.asset(
                  url_img + "User_logo.png",
                  width: 30,
                  height: 30,
                  fit: BoxFit.contain,
                ),
              ),
            )
          ],
          //them logo , anh nhan vat

          //anh profile login do moi hien , now just make like a demo

          backgroundColor: Colors.black,
        ),
        body: Center(
          child: _WidgetOptions.elementAt(_selectIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          currentIndex: _selectIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.shifting,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(
                Icons.search,
                size: 30,
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(
                Icons.history,
                size: 30,
              ),
              label: 'History',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(
                Icons.person,
                size: 30,
              ),
              label: 'Profile',
            ),
          ],
          
        ),
      ),
    );
  }
}
