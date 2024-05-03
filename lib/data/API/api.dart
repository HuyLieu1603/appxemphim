import 'dart:convert';
import 'package:appxemphim/data/model/category.dart';
import 'package:appxemphim/data/model/history/historyPurchase.dart';
import 'package:appxemphim/data/model/movielinks.dart';
import 'package:appxemphim/data/model/bank.dart';
import '../model/history/historyMovie.dart';
import 'package:appxemphim/data/model/movies.dart';
import 'package:http/http.dart' as http;
import 'package:appxemphim/data/model/account.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';
import '../model/accounts.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import '../model/register.dart';


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
              date: DateTime.parse(json['date']),
              img: json['img'],
              id: json['id']))
          .toList();
    }

    if (res.statusCode == 200) {
      Histories = lstHistory(res.body);
      print("ok");
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
            if (items['nametype'] == name.toLowerCase()) {
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
        itemString.add(a.nametype.toString());
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

  Future<Movies> fetchMovieById(String movieID) async {
    final baseurl = Uri.parse(
        'https://662fcdce43b6a7dce310ccfe.mockapi.io/api/v1/Movies{id}');
    final reponse = await http.get(baseurl);
    Movies movies = Movies();
    Movies parseAccounts(String responseBody) {
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
      // for (var item in parseAccounts(reponse.body)) {
      //   String? id = item.id;

      //   if (id != null) {
      //     for (var items in id as List<dynamic>) {
      //       if (items['id'] == movieID.toLowerCase()) {
      //         movies.add(item);
      //       }
      //     }
      //   }
      // }
      String? id = parseAccounts(reponse.body).id;
      if (id != null) {
        movies = parseAccounts(reponse.body);
      }
    }
    print(movies);
    return movies;
  }

  Future<Movies> addMovToHistory(String movieID) async {
    final uri = Uri.parse('${(api.baseUrl)}History');
    final res = await http.post(uri);
    Movies movies = Movies();
    if (res.statusCode == 200) {
      movies = await fetchMovieById(movieID);
    }
    print(movies);
    return movies;
  }
}
