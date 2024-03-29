import 'dart:convert';
import '../model/eventindex.dart';
import 'package:flutter/services.dart';

class ReadDataEventindex{
  Future<List<Eventindex>> loadDataEventindex() async{
    var datas = await rootBundle.loadString("assets/files/eventindex.json");
    var datajson = jsonDecode(datas);
    return (datajson['dataeventindex'] as List).map((e) => Eventindex.fromJson(e)).toList();
  }
}

