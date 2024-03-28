import 'package:flutter/material.dart';

import '../../data/model/movies.dart';
import '../../data/provider/moviesprovider.dart';
import '../bodywidget/searchmoviebody.dart';

import '../../data/model/service.dart';
import '../../data/provider/serviceprovider.dart';

class Searchmoviewidget extends StatefulWidget {
  const Searchmoviewidget({super.key});

  @override
  State<Searchmoviewidget> createState() => _SearchmoviewidgetState();
}

class _SearchmoviewidgetState extends State<Searchmoviewidget> {
  String _inputValue = '';

  List<Movies> lsMovies = [];
  Future<String> loadmovies() async {
    lsMovies = await ReadDataMovies().loadDataMovies();
    return '';
  }

  @override
  void initState() {
    super.initState();
    loadmovies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadmovies(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return Center(
            child: Column(
              children: [
                Container(
                    color: Colors.black,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(67, 60, 60, 1),
                              ),
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Row(children: [
                                const Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    onChanged: (value) {
                                      setState(() {
                                        _inputValue = value;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      hintText: 'Search game, show...',
                                      hintStyle: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                      alignLabelWithHint: true,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      border: InputBorder.none,
                                    ),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                                // se update thanh khi an vao se  thu am giong noi roi sao do truyen vo input
                                const Icon(
                                  Icons.mic_rounded,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                //
                              ]),
                            ),
                            
                          ],
                        ),
                      ),
                    )),
                Expanded(
                  child: Container(
                    color: Colors.black, // Thiết lập màu nền thành đen
                    child: ListView.builder(
                      itemCount: lsMovies.length,
                      itemBuilder: (context, index) {
                        return Searchmoviebody(lsMovies[index],context);
                      },
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
