import 'package:appxemphim/page/Detailwidget/menumoviewidget.dart';
import 'package:appxemphim/page/Detailwidget/searchmoviewidget.dart';
import 'package:appxemphim/page/logo.dart';
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
    LogoPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("For you",style: TextStyle(color: Colors.white,fontSize: 30),),
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 40,
               margin: EdgeInsets.only(right: 10),
              child: Image.asset(
                url_img + "H.png",
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
        actions: [// mai mot no se la nut 
          Container(
            height: 15,
            margin: EdgeInsets.only(right: 10),
            child: Image.asset(
              url_img + "User_logo.png",
              fit: BoxFit.fill,
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 30,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 30,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
        onTap: _onItemTapped,
      ),
    ));
  }
}
