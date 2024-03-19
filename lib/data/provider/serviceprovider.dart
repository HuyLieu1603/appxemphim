import 'dart:convert';
import '../model/service.dart';
import 'package:flutter/services.dart';

class ReadData{
  Future<List<Service>> loadData() async {
    var data = await rootBundle.loadString("assets/files/servicelist.json");
    var dataJson = jsonDecode(data);

    return (dataJson['data'] as List).map((e) => Service.fromJson(e)).toList();
  }
}