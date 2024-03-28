import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../data/model/movies.dart';
import '../../data/provider/moviesprovider.dart';
import '../Detailwidget/searchmoviewidget.dart';
import '../../config/const.dart';
import '../Detailwidget/detailmoviewidget.dart';

import 'package:intl/intl.dart';

Widget Searchmoviebody(Movies itemmovie, BuildContext context) {
  final screenSize = MediaQuery.of(context).size;

  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => DetailMovies(
                    objMov: itemmovie,
                  ))));
    },
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      width: double.infinity,
      height: 150,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(

          //chỉnh radius theo mong muốn
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              Container(
                width: 130, // Điều chỉnh kích thước hình ảnh theo nhu cầu
                height: 160,
                child: Image.asset(
                  urlimgmovies + itemmovie.img!,
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
                      '${itemmovie.name!.length > 17 ? Intl.message('${itemmovie.name!.substring(0, 15)}...') : itemmovie.name}',
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
              icon: Icon(
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
