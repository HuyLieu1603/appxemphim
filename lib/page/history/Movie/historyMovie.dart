// ignore_for_file: camel_case_types

import 'package:appxemphim/data/model/history/historyMovie.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/API/api.dart';

class historyMovie extends StatefulWidget {
  const historyMovie({super.key});

  @override
  State<historyMovie> createState() => _historyMovieState();
}

class _historyMovieState extends State<historyMovie> {
  Future<List<History>> fetchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('name').toString());
    return await APIResponsitory()
        .fetchHistory(prefs.getString('name').toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<History>>(
        future: fetchHistory(),
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
                  final itemProduct = snapshot.data![index];
                  return historyWidget(itemProduct, context);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget historyWidget(History his, BuildContext context) {
    return Container(
      child: Text('${his.idMovie}'),
    );
  }
}
