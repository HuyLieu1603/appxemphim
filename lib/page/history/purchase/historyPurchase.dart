// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:appxemphim/data/API/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/model/history/historyPurchase.dart';

class historyPurchaseWidget extends StatefulWidget {
  const historyPurchaseWidget({super.key});

  @override
  State<historyPurchaseWidget> createState() => _historyPurchaseWidgetState();
}

class _historyPurchaseWidgetState extends State<historyPurchaseWidget> {
  List<historyPurchase> lst = [];
  Future<List<historyPurchase>> fetchPurchase() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('name').toString());

    return lst = await APIResponsitory()
        .fetchPurchase(prefs.getString('name').toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Lịch sử thanh toán',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<List<historyPurchase>>(
        future: fetchPurchase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text("Không có dữ liệu"),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              // hoặc SizedBox
              height: MediaQuery.of(context)
                  .size
                  .height, // thiết lập chiều cao cố định hoặc dựa vào điều kiện
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  print(lst);
                  final item = snapshot.data![index];
                  return historyWidget(item, context);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget historyWidget(historyPurchase his, BuildContext context) {
  return Card(
    color: Color.fromARGB(255, 42, 42, 42),
    child: Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  'Tên gói dịch vụ: \n${utf8.decode(his.nameService.toString().codeUnits)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  'Giá: ${his.price}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 30,
            alignment: Alignment.center,
            child: Text(
              '${his.date?.hour.toString().padLeft(2, '0') ?? 'N/A'} Giờ ${his.date?.minute.toString().padLeft(2, '0') ?? 'N/A'} Phút | Ngày: ${his.date?.day.toString().padLeft(2, '0')}/${his.date?.month.toString().padLeft(2, '0')}/${his.date?.year}',
              style: const TextStyle(
                color: Color.fromARGB(255, 195, 192, 192),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
