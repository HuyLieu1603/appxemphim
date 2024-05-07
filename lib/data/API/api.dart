import 'package:appxemphim/data/model/category.dart';
import 'package:appxemphim/data/model/history/historyPurchase.dart';
import 'package:appxemphim/data/model/movielinks.dart';
import 'package:appxemphim/data/model/bank.dart';
import 'package:appxemphim/data/model/movies_continue/movies_continue.dart';
import '../model/history/historyMovie.dart';
import 'package:appxemphim/data/model/movies.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:appxemphim/data/model/account.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';
import '../model/history/historyMovie.dart';
import 'dart:convert' show json, utf8;

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
    }
    return Histories;
  }

  Future<List<historyPurchase>> fetchPurchase(String accountID) async {
    final baseurl =
        Uri.parse('${API().baseUrl}/historyPurchase'); // Sửa đường dẫn URL
    List<historyPurchase> lstPurchase = [];
    try {
      final res = await http.get(baseurl);

      if (res.statusCode == 200) {
        lstPurchase = lstHistory(res.body);
        print(lstPurchase[0].idAccount);
      } else {
        print("fail: ${res.statusCode}");
      }
    } catch (e) {
      print("Error: $e"); // Xử lý các lỗi xảy ra trong quá trình gửi yêu cầu
    }
    return lstPurchase;
  }

  List<historyPurchase> lstHistory(String respondbody) {
    final parsed = json.decode(respondbody).cast<Map<String, dynamic>>();
    return parsed
        .map<historyPurchase>((json) => historyPurchase(
              nameService: json['nameService'],
              price: json['price'],
              date:
                  DateTime.parse(json['date']), // Chuyển đổi sang kiểu DateTime
              des: json['des'],
              idAccount: json['idAccount'],
              id: json['id'],
            ))
        .toList();
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

  ///get data by Type///
  bool isComedyPresent(List<dynamic> types) {
    return types.any((type) => type['nametype'] == 'comedy');
  }

  Future<List<Movies>> fetchdatabyType(String name) async {
    final baseurl =
        Uri.parse('https://662fcdce43b6a7dce310ccfe.mockapi.io/api/v1/Movies');
    final reponse = await http.get(baseurl);
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
      for (var item in parseAccounts(reponse.body)) {
        Object? type = item.type;

        if (type != null) {
          for (var items in type as List<dynamic>) {
            final decodedString =
                utf8.decode(items['nametype'].toString().codeUnits);
            print(decodedString);

            if (decodedString == name.toLowerCase().trim()) {
              movies.add(item);
            }
          }
        }
      }
    }
    //print(movies);
    return movies;
  }

  Future<List<String>> fetchdataCategoryAll() async {
    final baseurl = Uri.parse(
        'https://662fcdce43b6a7dce310ccfe.mockapi.io/api/v1/Category');
    final reponse = await http.get(baseurl);
    List<Categorys> items = [];
    List<String> itemString = [];
    List<Categorys> parseAccounts(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed
          .map<Categorys>((json) => Categorys(
                nametype: json['nameCate'],
                id: json['id'],
              ))
          .toList();
    }

    if (reponse.statusCode == 200) {
      print("allcategory");
      items = parseAccounts(reponse.body);
      for (var a in items) {
        final decodedString = utf8.decode(a.nametype.toString().codeUnits);
        print(decodedString);
        itemString.add(decodedString);
      }
    } else {
      print("allcategory fail");
    }
    return itemString;
  }

  //get video link
  Future<String> fetchdataMoviesLink(String id) async {
    final baseurl = Uri.parse(
        'https://662fcdce43b6a7dce310ccfe.mockapi.io/api/v1/Movies/' +
            id +
            "//Movies_link");
    final reponse = await http.get(baseurl);
    List<MovieLink> take = [];
    String results = "";
    List<MovieLink> parseAccounts(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed
          .map<MovieLink>((json) => MovieLink(
                link: json['link'],
                idmovie: json['idmovie'],
                id: json['id'],
                movieId: json['movieId'],
              ))
          .toList();
    }

    if (reponse.statusCode == 200) {
      take = parseAccounts(reponse.body);
      results = take[0].link as String;
      if (results == "") {
        results = "https://www.youtube.com/watch?v=wr33qdjMV9c";
      }
    } else {}
    return results;
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

  Future<String> Moviescontinues(
      String id, String idname, String timess) async {
    var a = MoviesContinue(idname: idname, idmovie: id, times: timess);
    //UpdateMoviescontinues(a); update dc roi
    var url = Uri.parse(
        'https://662fcdce43b6a7dce310ccfe.mockapi.io/api/v1/Movies_continue');
    var body = json.encode(a.toJson());

    /////
    final baseurl = Uri.parse(
        'https://662fcdce43b6a7dce310ccfe.mockapi.io/api/v1/Movies_continue');
    final reponse = await http.get(baseurl);
    int countIDlink = 0;
    bool checkmovies = false;
    List<MoviesContinue> lstMoviesContinue = [];
    List<MoviesContinue> parseAccounts(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed
          .map<MoviesContinue>((json) => MoviesContinue(
                idname: json['idname'],
                idmovie: json['idmovie'],
                times: json['times'],
              ))
          .toList();
    }

    /*
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );
    */

    if (reponse.statusCode == 200) {
      lstMoviesContinue = parseAccounts(reponse.body);
      for (var item in lstMoviesContinue) {
        countIDlink += 1;
        if (item.idmovie == id && item.idname == idname) {
          UpdateMoviescontinues(a, countIDlink.toString());
          checkmovies = true;
        }
      }
      if (checkmovies != true) {
        var responsed = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: body,
        );
         print('Movies Create successfully');
      }
    } else {}
    print(a.idname);

    return '';
  }

  Future<String> UpdateMoviescontinues(
      MoviesContinue items, String locate) async {
    var url = Uri.parse(
        'https://662fcdce43b6a7dce310ccfe.mockapi.io/api/v1/Movies_continue/' +
            locate.trim());
    var body = json.encode(items.toJson());
    var response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );
    if (response.statusCode == 200) {
      // Handle successful account creation
      print('Movies Updated successfully');
    } else {
      // Handle errors
      print('Error: ${response.statusCode}');
    }

    return '';
  }

  Future<MoviesContinue> fectdateMoviescontinues(
    String id, String idname) async {
    final baseurl = Uri.parse(
        'https://662fcdce43b6a7dce310ccfe.mockapi.io/api/v1/Movies_continue');
    final reponse = await http.get(baseurl);
    int countIDlink = 0;
    bool checkmovies = false;
    var takedata = MoviesContinue(idname: null, idmovie: null, times: null);
    List<MoviesContinue> lstMoviesContinue = [];
    List<MoviesContinue> parseAccounts(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed
          .map<MoviesContinue>((json) => MoviesContinue(
                idname: json['idname'],
                idmovie: json['idmovie'],
                times: json['times'],
              ))
          .toList();
    }
    if (reponse.statusCode == 200) {
      lstMoviesContinue = parseAccounts(reponse.body);
      for (var item in lstMoviesContinue) {
        countIDlink += 1;
        if (item.idmovie == id && item.idname == idname) {
          checkmovies = true ;
          takedata = MoviesContinue(idname: idname, idmovie: id, times: item.times);
          
          return takedata;
        }
      }
    } else {}
    return takedata;
  }





}
