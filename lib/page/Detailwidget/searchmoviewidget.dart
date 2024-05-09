// ignore_for_file: unused_import, unused_field
import 'package:appxemphim/data/API/api.dart';
import 'package:appxemphim/page/Detailwidget/detailmoviewidget.dart';
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
  String? selectedValue;
  List<Movies> lsMovies = [];
  List<Movies> searchResults = [];

  Future<String> loadmovies() async {
    lsMovies = await APIResponsitory().fetchdataAll();
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
            child: Stack(
              children: [
                Container(
                    color: Colors.black,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(0),
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
                                        _inputValue = value.trim();
                                        if (_inputValue == "") {
                                          searchResults = [];
                                        } else {
                                          searchResults = lsMovies
                                              .where((movie) => movie.name!
                                                  .contains(_inputValue))
                                              .toList();
                                          print(searchResults);
                                        }
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      hintText: 'Tìm kiếm...',
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
                Positioned(
                  top: 50,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    color: Colors.black,
                    child: ListView.builder(
                      itemCount: lsMovies.length,
                      itemBuilder: (context, index) {
                        return Searchmoviebody(lsMovies[index], context);
                      },
                    ),
                  ),
                ),
                Positioned(
                  child: Container(
                    margin: EdgeInsets.only(top: 50),
                    height: searchResults.length > 5 ? 150 : null,
                    decoration: BoxDecoration(color: Colors.white),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('${searchResults[index].name}'),
                          onTap: () {
                           
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => DetailMovies(
                                        objMov: searchResults[index]))));
                            // Xử lý khi người dùng chọn một phim từ danh sách
                          },
                        );
                      },
                    ),
                  ),
                ),

                /*
                Expanded(
                  child: Container(
                    color: Colors.black, // Thiết lập màu nền thành đen
                    child: ListView.builder(
                      itemCount: lsMovies.length,
                      itemBuilder: (context, index) {
                        return Searchmoviebody(lsMovies[index], context);
                      },
                    ),
                  ),
                )
*/
              ],
            ),
          );
        });
  }
}
