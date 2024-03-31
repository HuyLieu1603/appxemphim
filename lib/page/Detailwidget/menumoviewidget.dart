// ignore_for_file: sized_box_for_whitespace, non_constant_identifier_names, unused_import

import 'package:flutter/material.dart';
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
  List<Movies> lsMoviesonlyHuflitx = [];
  Future<String> loadmoviesonlyHuflix() async {
    lsMoviesonlyHuflitx =
        await ReadbyCategory().loadBycategory("Only available on Huflix");
    return '';
  }

  //Anime
  List<Movies> lsAnime = [];
  Future<String> loadmoviesanime() async {
    lsAnime = await ReadbyCategory().loadBycategory("Anime");
    return '';
  }

  //New on Huflix
  List<Movies> lsNewonHuflix = [];
  Future<String> loadmoviesNewonHuflix() async {
    lsNewonHuflix = await ReadbyCategory().loadBycategory("New on Huflix");
    return '';
  }

  //Cartoon
  List<Movies> lsCartoon = [];
  Future<String> loadmovieslsCartoon() async {
    lsCartoon = await ReadbyCategory().loadBycategory("Cartoon");
    return '';
  }

  //Dramatic movie
  List<Movies> lsDramaticmovie = [];
  Future<String> loadmovieslsDramaticmovie() async {
    lsDramaticmovie = await ReadbyCategory().loadBycategory("Dramatic movie");
    return '';
  }

  //American adventure blockbuster
  List<Movies> lsAmericanab = [];
  Future<String> loadmoviesAmericanab() async {
    lsAmericanab =
        await ReadbyCategory().loadBycategory("American adventure blockbuster");
    return '';
  }

  @override
  void initState() {
    super.initState();
    loadmovies();
    loadmoviesonlyHuflix();
    loadmoviesanime();
    loadmoviesNewonHuflix();
    loadmovieslsCartoon();
    loadmovieslsDramaticmovie();
    loadmoviesAmericanab();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: FutureBuilder(
          future: loadmovies(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
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
          }),
    );
  }

  Widget OnlyHuflix(BuildContext context) {
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
                  future: loadmoviesonlyHuflix(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return Center(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: lsMoviesonlyHuflitx.length,
                        itemBuilder: (context, index) {
                          return Container(
                              width: 180,
                              margin: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset(
                                  urlimgmovies +
                                      lsMoviesonlyHuflitx[index].img!,
                                  fit: BoxFit.fill,
                                ),
                              ));
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
                buttonStyleData:const  ButtonStyleData(
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
                  future: loadmoviesanime(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return Center(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: lsAnime.length,
                        itemBuilder: (context, index) {
                          return Container(
                              width: 140,
                              margin: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset(
                                  urlimgmovies + lsAnime[index].img!,
                                  fit: BoxFit.fill,
                                ),
                              ));
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
                  future: loadmoviesNewonHuflix(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return Center(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: lsNewonHuflix.length,
                        itemBuilder: (context, index) {
                          return Container(
                              width: 140,
                              margin: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset(
                                  urlimgmovies + lsNewonHuflix[index].img!,
                                  fit: BoxFit.fill,
                                ),
                              ));
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
                  future: loadmovieslsCartoon(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return Center(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: lsCartoon.length,
                        itemBuilder: (context, index) {
                          return Container(
                              width: 140,
                              margin: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset(
                                  urlimgmovies + lsCartoon[index].img!,
                                  fit: BoxFit.fill,
                                ),
                              ));
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
                  future: loadmovieslsDramaticmovie(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return Center(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: lsDramaticmovie.length,
                        itemBuilder: (context, index) {
                          return Container(
                              width: 140,
                              margin: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset(
                                  urlimgmovies + lsDramaticmovie[index].img!,
                                  fit: BoxFit.fill,
                                ),
                              ));
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
                  future: loadmoviesAmericanab(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return Center(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: lsAmericanab.length,
                        itemBuilder: (context, index) {
                          return Container(
                              width: 140,
                              margin: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset(
                                  urlimgmovies + lsAmericanab[index].img!,
                                  fit: BoxFit.fill,
                                ),
                              ));
                        },
                      ),
                    );
                  })),
        ],
      ),
    );
  }
}
