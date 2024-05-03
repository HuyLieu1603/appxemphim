import 'dart:convert';
import 'package:appxemphim/data/model/bank.dart';
import 'package:appxemphim/data/model/movies.dart';
import 'package:http/http.dart' as http;
import 'package:appxemphim/data/model/account.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';

class API {
  final Dio _dio = Dio();
  String baseUrl = "https://662fcdce43b6a7dce310ccfe.mockapi.io/api/v1/";
  Dio get sendRequest => _dio;
}

class APIResponsitory {
  API api = API();

  Future<bool> fetchdata(String name, String pass) async {
    final baseurl = Uri.parse('${(API().baseUrl)}user');
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
        }
      }
    }
    return result;
  }

  Future<List<Movies>> fetchdataAll() async {
    final baseurl =
        Uri.parse('https://662fcdce43b6a7dce310ccfe.mockapi.io/api/v1/Movies');
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
    return accounts;
  }

  ///get data by category///
  Future<List<Movies>> fetchdatabyCategory(
      String nametable, String naneCategory) async {
    final baseurl = Uri.parse(
        'https://662fcdce43b6a7dce310ccfe.mockapi.io/api/v1/' + nametable);
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
      for (var item in all) {
        if (item.category == naneCategory.trim()) {
          movies.add(item);
        }
      }
    }
    return movies;
  }

  Future<List<Bank>> getBank(String name, String img) async {
    final uri = Uri.parse('${(api.baseUrl)}Bank');
    final res = await http.get(uri);
    List<Bank> banks = [];
    List<Bank> parseAccounts(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed
          .map<Bank>((json) =>
              Bank(id: json['id'], name: json['name'], img: json['img']))
          .toList();
    }

    if (res.statusCode == 200) {
      print('ok');
      banks = parseAccounts(res.body);
    }
    return banks;
  }
}
