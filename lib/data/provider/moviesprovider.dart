import 'dart:convert';
import '../model/movies.dart';
import 'package:flutter/services.dart';

class ReadDataMovies{
  Future<List<Movies>> loadDataMovies() async{
    var data = await rootBundle.loadString("assets/files/movielist.json");
    var datajson = jsonDecode(data);

    return (datajson['datamovie'] as List).map((e) => Movies.fromJson(e)).toList();
  }

   Future<Iterable<Movies>> loadDataMoviesbyId(int movieId) async{
    var data = await rootBundle.loadString("assets/files/movielist.json");
    var datajson = jsonDecode(data);

    return (datajson['datamovie'] as List).map((e) => Movies.fromJson(e)).where((e)=> e.id==movieId).toList();
  }



}


class ReadbyCategory{
   Future<List<Movies>> loadBycategory( String? loai) async{
    var data = await rootBundle.loadString("assets/files/movielist.json");
    var datajson = jsonDecode(data);

    return (datajson['datamovie'] as List).map((e) => Movies.fromJson(e)).where((e) => e.category == loai ).toList();
  }
}




