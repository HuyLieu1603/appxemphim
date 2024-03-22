import 'package:appxemphim/page/logo.dart';
import 'package:flutter/material.dart';

class NaviFrame extends StatefulWidget {
  const NaviFrame({Key? key}) : super(key: key);

  @override
  State<NaviFrame> createState() => _NaviFrameState();
}


class _NaviFrameState extends State<NaviFrame>{
  int _selectIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _WidgetOptions = <Widget>[
   
      LogoPage(),
      LogoPage(),
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
        title: const Text('demo' , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold), ),
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
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.person),
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




