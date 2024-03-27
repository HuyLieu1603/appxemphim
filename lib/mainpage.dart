import 'package:flutter/material.dart';
import 'page/homewidget.dart';
import 'page/payment/paymentwidget.dart';
import 'page/paymentmethod/paymentmethodwidget.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({Key? key}) : super(key: key);

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int _selectIndex = 0;
  static const List<Widget> _WidgetOptions = <Widget>[
    HomeWidget(),
    PaymentMethodWidget(),
    PaymentWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
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
              icon: Icon(Icons.card_giftcard),
              label: 'Paymentmethod',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_membership),
              label: 'Payment',
            ),
          ],
          currentIndex: _selectIndex,
          selectedItemColor: const Color.fromARGB(255, 11, 7, 233),
          onTap: _onItemTapped,
        ),
      ));
  }
}