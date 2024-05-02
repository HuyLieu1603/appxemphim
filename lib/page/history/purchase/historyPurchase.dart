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
  return Container(
    child: Text('${his.idAccount} ${his.date}'),
  );
}
