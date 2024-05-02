import 'dart:convert';
import 'package:appxemphim/data/model/history/historyPurchase.dart';
import 'package:appxemphim/data/model/movies.dart';
import 'package:http/http.dart' as http;
import 'package:appxemphim/data/model/account.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';
import '../model/history/historyMovie.dart';

class API {
  final Dio _dio = Dio();
  String baseUrl = "https://662fcdce43b6a7dce310ccfe.mockapi.io/api/v1/";
  Dio get sendRequest => _dio;
}

class APIResponsitory {
  API api = API();

  Future<bool> fetchdata(String name, String pass) async {
    final baseurl = Uri.parse('${(API().baseUrl)}user');
    //String baseurl = "https://6629a5d367df268010a13cf2.mockapi.io/api/v1";
    bool result = false;
    final reponse = await http.get(baseurl);
    List<Account> parseAccounts(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed
          .map<Account>((json) => Account(
                name: json['name'],
                pass: json['pass'],
                id: json['id'],
              ))
          .toList();
    }

    if (reponse.statusCode == 200) {
      List<Account> accounts = parseAccounts(reponse.body);
      for (var item in accounts) {
        if (item.name == name && item.pass == pass) {
          result = true;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('name', name);
        }
      }
    }
    return result;
  }

  Future<List<History>> fetchHistory(String accountID) async {
    final baseurl = Uri.parse('${(API().baseUrl)}History');
    List<History> Histories = [];
    final res = await http.get(baseurl);
    List<History> lstHistory(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed
          .map<History>((json) => History(
              idMovie: json['idMovie'],
              idAccount: json['idAccount'],
              date: json['date'],
              id: json['id']))
          .toList();
    }

    if (res.statusCode == 200) {
      Histories = lstHistory(res.body);
      print(Histories[0].idAccount);
    }
    return Histories;
  }

  // Future<List<historyPurchase>> fetchPurchase(String accountID) async {
  //   final baseurl = Uri.parse('${(API().baseUrl)}historyPurchase');
  //   List<historyPurchase> lstPurchase = [];
  //   final res = await http.get(baseurl);
  //   List<historyPurchase> lstHistory (String respondbody){

  //   }
  // }
  Future<List<Movies>> fetchdataAll() async {
  final baseurl = Uri.parse(
      'https://662fcdce43b6a7dce310ccfe.mockapi.io/api/v1/Movies');
  final reponse = await http.get(baseurl);
  List<Movies> accounts = [];
  List<Movies> parseAccounts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Movies>((json) => Movies(
              name: json['name'],
              img: json['img'],
              type: json['type'],
              des: json['des'],
              release: json['release'],
              time: json['time'],
              category: json['category'],
              id: json['id'],
            ))
        .toList();
  }
  if (reponse.statusCode == 200) {
    accounts = parseAccounts(reponse.body);
    
  }
  return accounts ;
}
///get data by category///
Future<List<Movies>> fetchdatabyCategory(String nametable,String naneCategory) async {
  final baseurl = Uri.parse(
      'https://662fcdce43b6a7dce310ccfe.mockapi.io/api/v1/'+nametable);
  final reponse = await http.get(baseurl);
  List<Movies> all = [];
  List<Movies> movies = [];
  List<Movies> parseAccounts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Movies>((json) => Movies(
              name: json['name'],
              img: json['img'],
              type: json['type'],
              des: json['des'],
              release: json['release'],
              time: json['time'],
              category: json['category'],
              id: json['id'],
            ))
        .toList();
  }
  if (reponse.statusCode == 200) {
    print('ok');
    all = parseAccounts(reponse.body);
    for(var item in all){
      if(item.category == naneCategory.trim()){
        movies.add(item);
      }
    }
  }
  return movies ;
}
}
