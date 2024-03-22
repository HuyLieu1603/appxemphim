import 'dart:convert';
import '../model/movies.dart';
import 'package:flutter/services.dart';

class ReadData{
  Future<List<Movies>> loadData() async{
    var data = await rootBundle.loadString("assets/files/movielist.json");
    var datajson = jsonDecode(data);

    return (datajson['datamovie'] as List).map((e) => Movies.fromJson(e)).toList();
  }
}

