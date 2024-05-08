// ignore_for_file: camel_case_types

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
                  'Tên gói dịch vụ: \n${his.nameService}',
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
            height: 50,
            alignment: Alignment.center,
            child: Text(
              'Ngày thanh toán: \n ${his.date}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
