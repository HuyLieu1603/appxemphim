import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:appxemphim/data/model/account.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class API {
  final Dio _dio = Dio();
  String baseUrl = "https://662f7f6e43b6a7dce30fb0bf.mockapi.io/api/v1/";
  Dio get sendRequest => _dio;
}

class APIResponsitory {
  API api = API();

  Map<String, dynamic> header() {
    return {
      'Content-Type': 'application/json',
    };
  }

  Future<int> checkLogin(String username, String password) async {
  final url = Uri.parse('http://mockapi.io/api/v1/account');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final accounts = data['data'];

    for (var account in accounts) {
      if (account['username'] == username && account['password'] == password) {
        return 1; // Đăng nhập đúng
      }
    }
  }

  return 0; // Đăng nhập sai hoặc có lỗi xảy ra
}
    
}
