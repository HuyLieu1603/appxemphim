// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_unnecessary_containers, non_constant_identifier_names

// import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:appxemphim/data/API/api.dart';
import 'package:appxemphim/page/viewmovie/viewmovie.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/widgets.dart';
import '../../config/const.dart';
// import 'package:intl/intl.dart';
import '../../data/model/movies.dart';
import '../../data/provider/moviesprovider.dart';

class DetailMovies extends StatefulWidget {
  final Movies objMov;

  const DetailMovies({Key? key, required this.objMov}) : super(key: key);

  @override
  State<DetailMovies> createState() => _DetailMoviesWidgetState();
}

class _DetailMoviesWidgetState extends State<DetailMovies> {
  List<Movies> detailMovies = [];
  bool isExpanded = false;
  bool isExpandedActors = false;
  bool isExpandedCategory = false;
  String timeplay = "";
  var takedata;
  String nameid = "";
  String Categoryss = "";
  late Future<String> _loadcurrentMovies;
  late Future<String> _loadCurrent;
  Future<String> loadCurrent(String movId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nameid = prefs.getString('name').toString();
    print(nameid);
    takedata = await APIResponsitory().fectdateMoviescontinues(
        widget.objMov.id.toString().trim(), nameid.toString().trim());
    timeplay = takedata;
    print(timeplay);
    detailMovies =
        await ReadDataMovies().loadDataMoviesbyId(movId) as List<Movies>;
    return '';
  }

  String links = "";

  Future<String> loadlink(String movId) async {
    links = await APIResponsitory().fetchdataMoviesLink(movId);
    return '';
  }

  Future<void> addMovToHis(String movieID) async {
    return await APIResponsitory().addMovToHistory(movieID);
  }

  @override
  void initState() {
    super.initState();
    _loadcurrentMovies = loadCurrent(widget.objMov.id!);
    _loadCurrent = loadlink(widget.objMov.id!);
    if (widget.objMov.type is Iterable) {
      var allCategorys = widget.objMov.type as Iterable;
      allCategorys.forEach((item) {
        Categoryss += utf8.decode(item['nametype'].toString().codeUnits);
        if (item != allCategorys.last) {
          Categoryss += ', ';
        }
      });
    } else {}
    print(Categoryss);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.objMov.id!);

    //String description ='Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eget justo ac turpis volutpat fermentum. ';

    String description = utf8.decode(widget.objMov.des.toString().codeUnits);
    String Actors =
        'Actors : diễn viên A ,diễn viên B ,diễn viên C ,diễn viên D ,diễn viên Ediễn viên D ,diễn viên E ';
    //String Categorys ="Category : Thể loại A ,Thể loại B ,Thể loại C ,Thể loại D  ";
    //String Categorys = "Category : Thể loại A ,Thể loại B ,Thể loại C ,Thể loại D  ";
    String Categorys = "Category : " + Categoryss;
    
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: FutureBuilder(
          future: _loadcurrentMovies,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              loadlink(widget.objMov.id!);
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return FutureBuilder(
                  future: _loadCurrent,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: screenSize.height,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(widget.objMov.img!),
                                      fit: BoxFit.contain,
                                      colorFilter: ColorFilter.mode(
                                        Colors.black87.withOpacity(0.1),
                                        BlendMode.dstATop,
                                      ),
                                    ),
                                    color: Colors.black),
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        Center(
                                          child: Container(
                                            height: 400,
                                            width: screenSize.width - 100,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      widget.objMov.img!),
                                                  fit: BoxFit.contain,
                                                  alignment:
                                                      Alignment.topCenter),
                                            ),
                                          ),
                                        ),
                                        /*Positioned(
                                  top: 36,
                                  right: 16,
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white54,
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        // Xử lý sự kiện khi nút close được nhấn
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ),*/
                                      ],
                                    ),
                                    Container(
                                      //height: screenSize.height - 200,
                                      width: screenSize.width,
                                      decoration: BoxDecoration(
                                          color: Colors.transparent
                                              .withOpacity(1)),
                                      child: Container(
                                        margin: const EdgeInsets.all(20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            //ten phim
                                            Container(
                                              child: Text(
                                                '${widget.objMov.name?.substring(0, 1).toUpperCase()}${widget.objMov.name?.substring(1)}',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 30,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '${widget.objMov.release}',
                                                  style: TextStyle(
                                                      color: Colors.white54),
                                                ),
                                                Icon(
                                                  Icons.calendar_month,
                                                  color: Colors.white54,
                                                  size: 20,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  '${widget.objMov.time}',
                                                  style: TextStyle(
                                                      color: Colors.white54),
                                                ),
                                                Icon(
                                                  Icons.access_time_sharp,
                                                  color: Colors.white54,
                                                ),
                                              ],
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 10),
                                              width: screenSize.width,
                                              height: 50,
                                              padding: const EdgeInsets.all(1),
                                              child: ElevatedButton(
                                                onPressed: () => {
                                                  //print(links),

                                                  addMovToHis(
                                                      widget.objMov.id!),
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          VideoDetails(
                                                        linkMov:
                                                            links.toString(),
                                                        objMov: widget.objMov,
                                                        timeplays:
                                                            timeplay.toString(),
                                                      ),
                                                    ),
                                                  )
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.white,
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 255, 255, 255),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  textStyle: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                child: const Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.play_arrow,
                                                      size: 40,
                                                      color: Colors.black,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      'Xem',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                                //des
                                                margin: const EdgeInsets.only(
                                                    top: 20),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      isExpanded
                                                          ? description
                                                          : description
                                                                  .substring(
                                                                      0, 70) +
                                                              '...',
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    if (description.length > 70)
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            isExpanded =
                                                                !isExpanded;
                                                          });
                                                        },
                                                        child: Text(
                                                          isExpanded
                                                              ? 'Thu gọn'
                                                              : 'Đọc thêm',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white54),
                                                        ),
                                                      ),
                                                    const SizedBox(height: 10),
                                                    const Row(
                                                      children: [
                                                        Text(
                                                          'Director : ',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white54),
                                                        ),
                                                        //ten dao dien
                                                        Text(
                                                          'Liêu Trương Gia Huy',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white54),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Text(
                                                      isExpandedActors
                                                          ? Actors
                                                          : Actors.substring(
                                                                  0, 50) +
                                                              '...',
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.white54),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Text(
                                                      isExpandedCategory
                                                          ? Categorys
                                                          : Categorys.substring(
                                                                  0, Categorys.length-2) +
                                                              '...',
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.white54),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    if (Actors.length > 50)
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            isExpandedActors =
                                                                !isExpandedActors;
                                                            isExpandedCategory =
                                                                !isExpandedCategory;
                                                          });
                                                        },
                                                        child: Text(
                                                          isExpandedActors
                                                              ? 'Thu gọn'
                                                              : 'Đọc thêm',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white54),
                                                        ),
                                                      ),
                                                  ],
                                                )),
                                          ],
                                        ),
                                      ),
                                    ) // Các thành phần giao diện khác ở đây
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                  });
            }
          },
        ),
      ),
    );
  }
}
