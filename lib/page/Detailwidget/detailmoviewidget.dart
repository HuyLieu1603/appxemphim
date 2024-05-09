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
  Movies mov = Movies();

  String timeplay = "";
  var takedata;
  late MoviesDirector moviesDirector;
  String nameid = "";
  String Categoryss = "";
  String Actorss = "";
  late Future<String> _loadcurrentMovies;
  late Future<String> _loadCurrent;
  Future<void> isFav(String idMovie) async {
    if (await (APIResponsitory().checkFav(idMovie))) {
      await delFav(idMovie);
      mov.isFavorite = false;
    } else {
      await addFav(idMovie);
      mov.isFavorite = true;
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

    return '';
  }

  /////Rating
  int _rating = 0;
  String _rankRating = "0";
  void rate(int rating) {
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
                // funtion code rating o day

                await APIResponsitory().fectMoviesRating(
                    nameid, widget.objMov.id!, rating.toString());
                _rankRating = await APIResponsitory()
                    .fecttotalidMoviesRating(widget.objMov.id!);
              
                //print(newrankRating);

                Navigator.of(context).pop();

                setState(() {
                  _rating = rating;
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

    //String description ='Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eget justo ac turpis volutpat fermentum. ';

    String description = utf8.decode(widget.objMov.des.toString().codeUnits);

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
                      String Actors = 'Actors : ' + Actorss;
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
                                                Spacer(),
                                                IconButton(
                                                  onPressed: () {
                                                    isFav(widget.objMov.id!);
                                                    setState(() {
                                                      mov.isFavorite =
                                                          !mov.isFavorite;
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.bookmark,
                                                    color: mov.isFavorite
                                                        ? Colors.red
                                                        : Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: 50,
                                              child: ListView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                children: <Widget>[
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      '${widget.objMov.release}',
                                                      style: TextStyle(
                                                        color: Colors.white54,
                                                      ),
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.calendar_month,
                                                    color: Colors.white54,
                                                    size: 20,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      '${widget.objMov.time}',
                                                      style: TextStyle(
                                                        color: Colors.white54,
                                                      ),
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.access_time_sharp,
                                                    color: Colors.white54,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        GestureDetector(
                                                          child: Icon(
                                                            Icons.star,
                                                            color: _rating >= 1
                                                                ? Colors.orange
                                                                : Colors.grey,
                                                          ),
                                                          onTap: () => rate(1),
                                                        ),
                                                        GestureDetector(
                                                          child: Icon(
                                                            Icons.star,
                                                            color: _rating >= 2
                                                                ? Colors.orange
                                                                : Colors.grey,
                                                          ),
                                                          onTap: () => rate(2),
                                                        ),
                                                        GestureDetector(
                                                          child: Icon(
                                                            Icons.star,
                                                            color: _rating >= 3
                                                                ? Colors.orange
                                                                : Colors.grey,
                                                          ),
                                                          onTap: () => rate(3),
                                                        ),
                                                        GestureDetector(
                                                          child: Icon(
                                                            Icons.star,
                                                            color: _rating >= 4
                                                                ? Colors.orange
                                                                : Colors.grey,
                                                          ),
                                                          onTap: () => rate(4),
                                                        ),
                                                        GestureDetector(
                                                          child: Icon(
                                                            Icons.star,
                                                            color: _rating >= 5
                                                                ? Colors.orange
                                                                : Colors.grey,
                                                          ),
                                                          onTap: () => rate(5),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      _rankRating + "/5.0",
                                                      style: TextStyle(
                                                        color: Colors.white54,
                                                      ),
                                                    ),
                                                  ),
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
                                                          'Director : ',
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
}
