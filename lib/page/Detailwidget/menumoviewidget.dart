// ignore_for_file: sized_box_for_whitespace, non_constant_identifier_names, unused_import

import 'package:appxemphim/data/API/api.dart';
import 'package:appxemphim/page/Detailwidget/detailmoviewidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../data/model/movies.dart';
import '../../data/provider/moviesprovider.dart';
import '../../config/const.dart';
import '../../data/model/eventindex.dart';
import '../../data/provider/eventindexprovider.dart';
import '../bodywidget/menumoviebody.dart';

import 'package:dropdown_button2/dropdown_button2.dart';

class Menumoviewidget extends StatefulWidget {
  const Menumoviewidget({super.key});

  @override
  State<Menumoviewidget> createState() => _MenumoviewidgetState();
}

class _MenumoviewidgetState extends State<Menumoviewidget> {
  final List<String> items = [
    'Comedy',
    'Adventure',
    'Science Fiction',
    'Love',
    'War',
    'History',
    'Children',
    'Music',
    'Dreamy',
    'Fantasy horror',
    'Survival',
    'Oscar',
    'Supernatural',
    'Teenager',
    'Zombie',
    'Detective fiction',
    'Psychological sensation',
    'Resonant drama',
    'Far West'
  ];
  String? selectedValue;
  List<Movies> lsMovies = [];
  Future<String> loadmovies() async {
    lsMovies = await ReadDataMovies().loadDataMovies();
    return '';
  }

  //onlyhuflit
  /* 
  List<Movies> lsMoviesonlyHuflitx = [];
  Future<String> loadmoviesonlyHuflix() async {
    lsMoviesonlyHuflitx =
        await ReadbyCategory().loadBycategory("Only available on Huflix");
    return '';
  }
  List<Movies> lsMoviesonlyHuflitxfecth = [];
  Future<String> OnlyHuflixfecth(String name) async {
    lsMoviesonlyHuflitxfecth = await fetchdataOnlyHuflix(name);
    return '';
  }
  */
  List<Movies> lsOnlyhf = [];
  Future<String> movie_onlyhuflix(String name, String nameCate) async {
    lsOnlyhf = await APIResponsitory().fetchdatabyCategory(name, nameCate);
    return '';
  }

  //Anime
  /*
  List<Movies> lsAnime = [];
  Future<String> loadmoviesanime() async {
    lsAnime = await ReadbyCategory().loadBycategory("Anime");
    return '';
  }
  List<Movies> lsMovieslsAnimefetch = [];
  Future<String> animefecth(String name) async {
    lsMovieslsAnimefetch = await fetchdataOnlyHuflix(name);
    return '';
  }
  */
  List<Movies> lsAnime = [];
  Future<String> movie_anime(String name, String nameCate) async {
    lsAnime = await APIResponsitory().fetchdatabyCategory(name, nameCate);
    return '';
  }

  //New on Huflix
  /*
  List<Movies> lsNewonHuflix = [];
  Future<String> loadmoviesNewonHuflix() async {
    lsNewonHuflix = await ReadbyCategory().loadBycategory("New on Huflix");
    return '';
  }*/

  List<Movies> lsNewonHuflix = [];
  Future<String> movie_NewonHuflix(String name, String nameCate) async {
    lsNewonHuflix = await APIResponsitory().fetchdatabyCategory(name, nameCate);
    return '';
  }

  //Cartoon
  List<Movies> lsCartoon = [];
  Future<String> movie_Cartoon(String name, String nameCate) async {
    lsCartoon = await APIResponsitory().fetchdatabyCategory(name, nameCate);
    return '';
  }

  //Dramatic movie
  List<Movies> lsDramaticmovie = [];
  Future<String> movie_Dramaticmovie(String name, String nameCate) async {
    lsDramaticmovie = await APIResponsitory().fetchdatabyCategory(name, nameCate);
    return '';
  }

  //American adventure blockbuster
  List<Movies> lsAmericanab = [];
  Future<String> movie_Americanab(String name, String nameCate) async {
    lsAmericanab = await APIResponsitory().fetchdatabyCategory(name, nameCate);
    return '';
  }

  @override
  void initState() {
    super.initState();
    loadmovies();
    //loadmoviesonlyHuflix();
    //loadmoviesanime();
    //loadmoviesNewonHuflix();
    //loadmovieslsCartoon();
    //loadmovieslsDramaticmovie();
    //loadmoviesAmericanab();
    //test
    //OnlyHuflixfecth('OnlyHuflix');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: FutureBuilder(
          future: loadmovies(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                  child: ListView(
                children: [
                  menuTopBar(context),
                  OnlyHuflix(context),
                  AnimeSeries(context),
                  NewonHuflix(context),
                  Cartoons(context),
                  Dramatics(context),
                  Americanab(context),
                ],
              ));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget widget_movie(Movies item, BuildContext context) {
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
          width: 180,
          margin: const EdgeInsets.fromLTRB(0, 5, 5, 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              item.img!,
              fit: BoxFit.fill,
            ),
          )),
    );
  }
    Widget widget_movie_small(Movies item, BuildContext context) {
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
          width: 140,
          margin: const EdgeInsets.fromLTRB(0, 5, 5, 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              item.img!,
              fit: BoxFit.fill,
            ),
          )),
    );
  }

  Widget OnlyHuflix(BuildContext context) {
    //print(lsMoviesonlyHuflitxfecth);
    return Container(
      // nguyen khung phim chi co tren netflex
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            //chi muc
            'Only available on Huflix',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Container(
              //hinh anh
              height: 280,
              child: FutureBuilder(
                  future:
                      movie_onlyhuflix("Movies", 'Only available on Huflix'),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return Center(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: lsOnlyhf.length,
                        itemBuilder: (context, index) {
                          return widget_movie(lsOnlyhf[index],context);
                        },
                      ),
                    );
                  })),
        ],
      ),
    );
  }

  Widget menuTopBar(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 30),
            decoration: BoxDecoration(
              border: Border.all(
                style: BorderStyle.solid,
                width: 0.8,
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(19),
            ),
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'TV series',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            width: 80,
            decoration: BoxDecoration(
              border: Border.all(
                style: BorderStyle.solid,
                width: 0.8,
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(19),
            ),
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Movies',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                style: BorderStyle.solid,
                width: 0.8,
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(19),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: const Text(
                  'Category',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                items: items
                    .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
                value: selectedValue,
                onChanged: (value) {
                  setState(() {});
                },
                buttonStyleData: const ButtonStyleData(
                  height: 40,
                  width: 120,
                  padding: EdgeInsets.only(left: 14, right: 14),
                  elevation: 2,
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down_outlined,
                  ),
                  iconSize: 24,
                  iconEnabledColor: Colors.white,
                  iconDisabledColor: Colors.grey,
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 200,
                  width: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.black,
                  ),
                  offset: const Offset(-20, 0),
                  scrollbarTheme: ScrollbarThemeData(
                    radius: const Radius.circular(40),
                    thickness: MaterialStateProperty.all(6),
                    thumbVisibility: MaterialStateProperty.all(true),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                  padding: EdgeInsets.only(left: 14, right: 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget AnimeSeries(BuildContext context) {
    return Container(
      // nguyen khung phim chi co tren netflex
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            //chi muc
            'Anime Series',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Container(
              //hinh anh
              height: 210,
              child: FutureBuilder(
                  future: movie_anime("Movies", 'Anime'),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return Center(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: lsAnime.length,
                        itemBuilder: (context, index) {
                          return widget_movie_small(lsAnime[index],context);
                        },
                      ),
                    );
                  })),
        ],
      ),
    );
  }

  Widget NewonHuflix(BuildContext context) {
    return Container(
      // nguyen khung phim chi co tren netflex
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            //chi muc
            'New on Huflix',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Container(
              //hinh anh
              height: 210,
              child: FutureBuilder(
                  future: movie_NewonHuflix("Movies", 'New on Huflix'),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return Center(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: lsNewonHuflix.length,
                        itemBuilder: (context, index) {
                          return widget_movie_small(lsNewonHuflix[index],context);
                        },
                      ),
                    );
                  })),
        ],
      ),
    );
  }

  Widget Cartoons(BuildContext context) {
    return Container(
      // nguyen khung phim chi co tren netflex
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            //chi muc
            'Cartoon',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 3,
          ),
          Container(
              //hinh anh
              height: 210,
              child: FutureBuilder(
                  future: movie_Cartoon("Movies", "Cartoon"),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return Center(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: lsCartoon.length,
                        itemBuilder: (context, index) {
                           return widget_movie_small(lsCartoon[index],context);
                        },
                      ),
                    );
                  })),
        ],
      ),
    );
  }

  Widget Dramatics(BuildContext context) {
    return Container(
      // nguyen khung phim chi co tren netflex
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            //chi muc
            'Dramatic movie',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Container(
              //hinh anh
              height: 210,
              child: FutureBuilder(
                  future: movie_Dramaticmovie("Movies", "Dramatic movie"),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return Center(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: lsDramaticmovie.length,
                        itemBuilder: (context, index) {
                           return widget_movie_small(lsDramaticmovie[index],context);
                        },
                      ),
                    );
                  })),
        ],
      ),
    );
  }

  Widget Americanab(BuildContext context) {
    return Container(
      // nguyen khung phim chi co tren netflex
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            //chi muc
            'American adventure blockbuster',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Container(
              //hinh anh
              height: 210,
              child: FutureBuilder(
                  future: movie_Americanab(
                      "Movies", "American adventure blockbuster"),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return Center(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: lsAmericanab.length,
                        itemBuilder: (context, index) {
                          return widget_movie_small(lsDramaticmovie[index],context);
                        },
                      ),
                    );
                  })),
        ],
      ),
    );
  }
}
