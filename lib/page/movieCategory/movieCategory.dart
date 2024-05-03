import 'package:appxemphim/data/API/api.dart';
import 'package:appxemphim/data/model/category.dart';
import 'package:appxemphim/page/Detailwidget/detailmoviewidget.dart';
import 'package:appxemphim/page/user/optionalaccount.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '../../config/const.dart';
import '../../data/model/movies.dart';
import '../../data/provider/moviesprovider.dart';

class MovieByCate extends StatefulWidget {
  final String category_object;
  const MovieByCate({Key? key, required this.category_object})
      : super(key: key);

  @override
  State<MovieByCate> createState() => _MovieByCateWidgetState(category_object);
}

class _MovieByCateWidgetState extends State<MovieByCate> {
  String nametype = "";
  _MovieByCateWidgetState(String category_object) {
    nametype = category_object;
  }

  List<Movies> Movie = [];
  Future<String> loadCurrent() async {
    Movie = await APIResponsitory().fetchdatabyType(nametype.toLowerCase());
    return '';
  }

  @override
  void initState() {
    super.initState();
    loadCurrent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${nametype}",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          // mai mot no se la nut
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OptionalAccount(),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: Image.asset(
                url_img + "User_logo.png",
                width: 30,
                height: 30,
                fit: BoxFit.contain,
              ),
            ),
          )
        ],
        //them logo , anh nhan vat

        //anh profile login do moi hien , now just make like a demo

        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: FutureBuilder(
            future: loadCurrent(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Center(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: Movie.length,
                    itemBuilder: (context, index) {
                      return demo(Movie[index], context);
                    },
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  Widget demo(Movies item, BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => DetailMovies(
                      objMov: item,
                    ))));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        width: double.infinity,
        height: 150,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
            //chỉnh radius theo mong muốn
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                Container(
                  width: 120, // Điều chỉnh kích thước hình ảnh theo nhu cầu
                  height: 170,
                  child: Image.network(
                    item.img!,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  //decoration: BoxDecoration(color: Colors.amber),
                  height: 50,

                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${item.name!.length > 17 ? Intl.message('${item.name!.substring(0, 15)}...') : item.name}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                      )),
                ),
              ],
            ),
            Container(
              child: IconButton(
                onPressed: () {
                  // Xử lý sự kiện khi nhấn vào nút play
                },
                icon: const Icon(
                  Icons.play_circle_outline,
                  color: Colors.white,
                  size: 30,
                ), // Icon của nút play
              ),
            ),
          ],
        ),

        /*
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration:const BoxDecoration(color: Color.fromARGB(255, 139, 171, 231)),
      child: Container(
        width: 150,
        height: 120,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)
            //chỉnh radius theo mong muốn
            ),
        child: Image.asset(
          urlimgmovies + itemmovie.img!,
          fit: BoxFit.cover,
        ),
      ),*/
      ),
    );
  }
}
