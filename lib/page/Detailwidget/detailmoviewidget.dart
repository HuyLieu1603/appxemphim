// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_unnecessary_containers, non_constant_identifier_names, prefer_const_constructors

// import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:appxemphim/data/API/api.dart';
import 'package:appxemphim/data/model/movies_directors/movies_directors.dart';
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
  bool isFavorite = false;
  late Future<bool> Check;

  Movies mov = Movies();

  String timeplay = "";
  var takedata;
  late MoviesDirector moviesDirector;
  String nameid = "";
  String Categoryss = "";
  String Actorss = "";
  late Future<String> _loadcurrentMovies;
  late Future<String> _loadCurrent;

  Future<bool> check(String idMovie) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await APIResponsitory()
        .checkFav(idMovie, prefs.getString('name').toString());
  }

  late Future<bool> Function(String) checkFunction;

  Future<void> isFav(String idMovie) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (await (APIResponsitory()
        .checkFav(idMovie, prefs.getString('name').toString()))) {
      await delFav(idMovie);
      isFavorite = false;
    } else {
      await addFav(idMovie);
      isFavorite = true;
    }
  }

  Future<void> addFav(String movieID) async {
    await APIResponsitory().insertFavorite(movieID);
  }

  Future<void> delFav(String movieID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await APIResponsitory()
        .deleteFavorite(movieID, prefs.getString('name').toString());
  }

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

    moviesDirector =
        await APIResponsitory().fectchMoviesDirector(widget.objMov.id!);

    if (moviesDirector.Actor is Iterable) {
      var allActors = moviesDirector.Actor as Iterable;
      allActors.forEach((element) {
        Actorss += utf8.decode(element['nameActors'].toString().codeUnits);
        if (element != allActors.last) {
          Actorss += ', ';
        }
      });
      print(Actorss);
    }

    _rating = int.parse(await APIResponsitory()
        .fectdataMoviesRating(nameid, widget.objMov.id!));
    _rankRating =
        await APIResponsitory().fecttotalidMoviesRating(widget.objMov.id!);
    _AllRatingmovies =
        await APIResponsitory().fecthMoviesTotal(widget.objMov.id!);

    return '';
  }

  /////Rating
  int _rating = 0;
  String _rankRating = "0";
  String _AllRatingmovies = "0";
  void rate(int rating) async {
    //Other actions based on rating such as api calls.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thông báo', textAlign: TextAlign.center),
          content: const Text(
            'Bạn có muốn đánh giá phim',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Có'),
              onPressed: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
                // funtion code rating o day
                await APIResponsitory().fectMoviesRating(
                    nameid, widget.objMov.id!, rating.toString());
                _rankRating = await APIResponsitory()
                    .fecttotalidMoviesRating(widget.objMov.id!);
                _AllRatingmovies =
                    await APIResponsitory().fecthMoviesTotal(widget.objMov.id!);

                setState(() {
                  _rating = rating;
                });
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  // Hàm callback này sẽ được gọi sau khi quá trình xây dựng lại cây widget hoàn thành
                  // Đặt mã logic của bạn ở đây để xử lý sau khi setState() hoàn tất
                  Navigator.of(context).pop(true);
                  Navigator.of(context).pop(true);
                });
                noticfav();
              },
            ),
            TextButton(
              child: const Text('Không'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }

  void noticfav() {
    final snackBar;

    snackBar = SnackBar(
      content: Text("đánh giá thành công"),
      duration: Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
    Check = check(widget.objMov.id!);
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

    //print(Actorss);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.objMov.id!);
    bool result;

    //String description ='Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eget justo ac turpis volutpat fermentum. ';

    String description = utf8.decode(widget.objMov.des.toString().codeUnits);

    //String Categorys ="Category : Thể loại A ,Thể loại B ,Thể loại C ,Thể loại D  ";
    //String Categorys = "Category : Thể loại A ,Thể loại B ,Thể loại C ,Thể loại D  ";
    String Categorys = "Thể loại : " + Categoryss;

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
              return Container(
                height: screenSize.height,
                width: screenSize.width,
                decoration: BoxDecoration(color: Colors.black),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
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
                      String Actors = 'Diễn viên : ' + Actorss;
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
                                            Row(
                                              children: [
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
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                              child: Text(
                                                _AllRatingmovies + ' đánh giá',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Container(
                                              height: 15,
                                              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.white
                                                )
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                _rankRating + "/5.0",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                              ],
                                            ),
                                            
                                            const SizedBox(
                                              height: 10,
                                            ),

                                            Container(
                                              height: 40,
                                              child: ListView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                children: <Widget>[
                                                  Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                          color: Color.fromARGB(
                                                              255, 47, 47, 47),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              '${widget.objMov.release}',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .calendar_month,
                                                            color: Colors.white,
                                                            size: 20,
                                                          ),
                                                        ],
                                                      )),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                          color: Color.fromARGB(
                                                              255, 47, 47, 47),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              '${widget.objMov.time}',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .access_time_sharp,
                                                            color: Colors.white,
                                                          ),
                                                        ],
                                                      )),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                          color: Color.fromARGB(
                                                              255, 47, 47, 47),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <Widget>[
                                                                GestureDetector(
                                                                  child: Icon(
                                                                    Icons.star,
                                                                    color: _rating >=
                                                                            1
                                                                        ? Colors
                                                                            .orange
                                                                        : Colors
                                                                            .grey,
                                                                  ),
                                                                  onTap: () =>
                                                                      rate(1),
                                                                ),
                                                                GestureDetector(
                                                                  child: Icon(
                                                                    Icons.star,
                                                                    color: _rating >=
                                                                            2
                                                                        ? Colors
                                                                            .orange
                                                                        : Colors
                                                                            .grey,
                                                                  ),
                                                                  onTap: () =>
                                                                      rate(2),
                                                                ),
                                                                GestureDetector(
                                                                  child: Icon(
                                                                    Icons.star,
                                                                    color: _rating >=
                                                                            3
                                                                        ? Colors
                                                                            .orange
                                                                        : Colors
                                                                            .grey,
                                                                  ),
                                                                  onTap: () =>
                                                                      rate(3),
                                                                ),
                                                                GestureDetector(
                                                                  child: Icon(
                                                                    Icons.star,
                                                                    color: _rating >=
                                                                            4
                                                                        ? Colors
                                                                            .orange
                                                                        : Colors
                                                                            .grey,
                                                                  ),
                                                                  onTap: () =>
                                                                      rate(4),
                                                                ),
                                                                GestureDetector(
                                                                  child: Icon(
                                                                    Icons.star,
                                                                    color: _rating >=
                                                                            5
                                                                        ? Colors
                                                                            .orange
                                                                        : Colors
                                                                            .grey,
                                                                  ),
                                                                  onTap: () =>
                                                                      rate(5),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                      padding:
                                                          EdgeInsets.all(0),
                                                      decoration: BoxDecoration(
                                                          color: Color.fromARGB(
                                                              255, 47, 47, 47),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          IconButton(
                                                            onPressed: () {
                                                              isFav(widget
                                                                  .objMov.id!);
                                                              setState(() {
                                                                isFavorite =
                                                                    !isFavorite;
                                                              });
                                                            },
                                                            icon: Icon(
                                                              Icons.bookmark,
                                                              color: isFavorite
                                                                  ? Colors.red
                                                                  : Colors
                                                                      .white,
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                ],
                                              ),
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
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Đạo diễn : ',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white54),
                                                        ),
                                                        //ten dao dien
                                                        Text(
                                                          '${moviesDirector.Director}',
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
                                                                  0,
                                                                  Actors
                                                                      .length) +
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
                                                                  0,
                                                                  Categorys
                                                                      .length) +
                                                              '...',
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.white54),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    if (Actors.length >
                                                        Actors.length - 1)
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

  Widget _buildProduct(
      Movies mov, BuildContext context, AsyncSnapshot<bool> test) {
    final bool isFavorite = test.data ?? false;
    return Card(
      child: ElevatedButton(
        onPressed: () {
          isFav(mov.id!);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 4, 76, 136),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Đặt góc bo tròn
          ),
          // Đặt khoảng cách đệm
          // Các thuộc tính khác nếu cần thiết
        ),
        child: Container(
          width: 25.0, // Đặt kích thước rộng
          height: 25.0, // Đặt kích thước cao
          child: Icon(
            Icons.favorite,
            color: isFavorite ? Colors.amber[800] : Colors.white,
          ),
        ),
      ),
    );
  }
}
