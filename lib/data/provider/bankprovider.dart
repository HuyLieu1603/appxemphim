import '../model/bankmodel.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class ReadData {
  Future<List<Bank>> loadData() async {
    var data = await rootBundle.loadString("assets/files/banklist.json");
    var dataJson = jsonDecode(data);

    return (dataJson['data'] as
    List).map((e) => Bank.fromJson(e)).toList();
  }
}