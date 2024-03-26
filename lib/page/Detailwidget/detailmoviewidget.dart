import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../config/const.dart';
import 'package:intl/intl.dart';
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
  late Future<String> _loadcurrentMovies;
  Future<String> loadCurrent(int movId) async {
    detailMovies =
        await ReadDataMovies().loadDataMoviesbyId(movId) as List<Movies>;
    return '';
  }

  @override
  void initState() {
    super.initState();
    _loadcurrentMovies = loadCurrent(widget.objMov.id!);
  }

  @override
  Widget build(BuildContext context) {
    String description =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eget justo ac turpis volutpat fermentum. Integer ac justo nec eros consequat ultricies. Quisque auctor, nunc at varius ultrices, nisi libero tincidunt orci, sed vestibulum elit purus et mauris. ';
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: _loadcurrentMovies,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: screenSize.height,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  urlimgmovies + detailMovies[0].img!),
                              fit: BoxFit.fill,
                              colorFilter: ColorFilter.mode(
                                Color.fromARGB(255, 31, 28, 28)
                                    .withOpacity(0.1),
                                BlendMode.dstATop,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 400,
                                    width: screenSize.width,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(urlimgmovies +
                                              detailMovies[0].img!),
                                          fit: BoxFit.cover,
                                          alignment: Alignment.topCenter),
                                    ),
                                  ),
                                  
                                  Positioned(
                                    top: 16,
                                    right: 16,
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: const Color.fromARGB(
                                            255, 11, 11, 11),
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          // Xử lý sự kiện khi nút close được nhấn
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: screenSize.height - 400,
                                width: screenSize.width,
                                decoration: BoxDecoration(
                                    color: Colors.transparent.withOpacity(1)),
                                child: Container(
                                  margin: EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //ten phim
                                      Container(
                                        child: Text(
                                          '${detailMovies[0].name}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '2019',
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
                                            '1g 30p',
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
                                        margin: EdgeInsets.only(top: 10),
                                        width: screenSize.width,
                                        height: 50,
                                        padding: const EdgeInsets.all(1),
                                        
                                        child: ElevatedButton(
                                          onPressed: () => {},
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor:
                                                Color.fromARGB(255, 255, 255, 255),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            textStyle: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.play_arrow,size: 40,color: Colors.black,),
                                              SizedBox(width: 5,),
                                              Text('Play',style: TextStyle(color: Colors.black),),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(//des
                                        margin: EdgeInsets.only(top: 20),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              isExpanded ? description : description.substring(0, 100) + '...',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            SizedBox(height: 8),
                                            if (description.length > 100)
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    isExpanded = !isExpanded;
                                                  });
                                                },
                                                child: Text(
                                                  isExpanded ? 'Thu gọn' : 'Đọc thêm',
                                                  style: TextStyle(color: Colors.white54),
                                                ),
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Text('Director : ' , style: TextStyle(color: Colors.white54),),
                                                //ten dao dien
                                                Text('Liêu Trương Gia Huy'  , style: TextStyle(color: Colors.white),),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Text('Actor : ' , style: TextStyle(color: Colors.white54),),
                                                //ten dao dien
                                                Text('diễn viên A ,diễn viên B ,diễn viên C ,diễn viên D ,diễn viên E'  , style: TextStyle(color: Colors.white),),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Text('Category : ' , style: TextStyle(color: Colors.white54),),
                                                //ten dao dien
                                                Text('Thể loại A ,Thể loại B ,Thể loại C ,Thể loại D  '  , style: TextStyle(color: Colors.white),),
                                              ],
                                            ),
                                            
                                          ],
                                        )
                                      ),
                                     
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
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
