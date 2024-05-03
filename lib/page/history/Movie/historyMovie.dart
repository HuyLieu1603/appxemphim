// ignore_for_file: camel_case_types

import 'package:appxemphim/data/model/history/historyMovie.dart';
import 'package:appxemphim/data/model/movies.dart';
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Lịch sử xem phim'),
        backgroundColor: Colors.black,
      ),
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
              child: Text(
                "Không có dữ liệu",
                style: TextStyle(color: Colors.white),
              ),
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
                  final history = snapshot.data![index];
                  return historyWidget(history, context);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget historyWidget(History his, BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 42, 42, 42),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              child: Image.network(his.img.toString()),
              width: 100,
              height: 100,
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              height: 100,
              alignment: Alignment.center,
              child: Text(
                '${his.idMovie} \n Thời gian xem: \n ${his.date}',
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
}
