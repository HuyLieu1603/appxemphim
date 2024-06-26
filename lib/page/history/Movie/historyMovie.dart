// ignore_for_file: camel_case_types

import 'package:appxemphim/config/const.dart';
import 'package:appxemphim/data/model/history/historyMovie.dart';
import 'package:appxemphim/data/model/movies.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/API/api.dart';
import '../../Detailwidget/detailmoviewidget.dart';

class historyMovie extends StatefulWidget {
  const historyMovie({super.key});

  @override
  State<historyMovie> createState() => _historyMovieState();
}

class _historyMovieState extends State<historyMovie> {
  Future<List<History>> fetchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('name').toString());
    List<History> historyList = await APIResponsitory()
        .fetchHistory(prefs.getString('name').toString());
    sortHistoryByDate(historyList); // Sắp xếp danh sách lịch sử
    return historyList;
  }

  String capslock(String s) {
    List<String> words = s.split(' ');
    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] = words[i][0].toUpperCase() + words[i].substring(1);
      }
    }
    return words.join(' ');
  }

  void sortHistoryByDate(List<History> historyList) {
    historyList.sort((a, b) => b.date!.compareTo(a.date!));
  }

  Future<Movies> fetchMovie(String id) async {
    return await APIResponsitory().fetchMovieById(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Lịch sử xem phim',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
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
      color: Color.fromARGB(255, 32, 32, 32),
      child: InkWell(
        onTap: () async {
          Movies mov = await fetchMovie(his.idMovie!);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => DetailMovies(
                        objMov: mov,
                      ))));
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                width: 100,
                height: 150,
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  his.img.toString(),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 145,
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 223,
                      child: Text(
                        capslock(his.nameMovie!),

                        maxLines: 2, // Giới hạn số dòng
                        overflow: TextOverflow
                            .ellipsis, // Xử lý trường hợp text dài vượt quá số dòng giới hạn
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Text(
                      'Đã xem lúc: ${his.date?.hour.toString().padLeft(2, '0') ?? 'N/A'}:${his.date?.minute.toString().padLeft(2, '0') ?? 'N/A'} | Ngày: ${his.date?.day.toString().padLeft(2, '0')}/${his.date?.month.toString().padLeft(2, '0')}/${his.date?.year}',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 178, 178, 178), fontSize: 13,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
