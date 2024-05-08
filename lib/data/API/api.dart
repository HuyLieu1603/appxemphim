import 'package:appxemphim/data/model/category.dart';
import 'package:appxemphim/data/model/history/historyPurchase.dart';
import 'package:appxemphim/data/model/movielinks.dart';
import 'package:appxemphim/data/model/bank.dart';
import 'package:appxemphim/data/model/movies_continue/movies_continue.dart';
import 'package:intl/intl.dart';
import '../model/history/historyMovie.dart';
import 'package:appxemphim/data/model/movies.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:appxemphim/data/model/accounts.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/history/historyMovie.dart';
import 'dart:convert' show json, jsonDecode, jsonEncode, utf8;
import '../model/accounts.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import '../model/register.dart';
import '../../data/model/service.dart';
import '../../page/payment/extendservice.dart';

class API {
  final Dio _dio = Dio();
  String baseUrl = "https://662fcdce43b6a7dce310ccfe.mockapi.io/api/v1/";
  Dio get sendRequest => _dio;
}

class APIResponsitory {
  API api = API();

  Future<bool> fetchdata(String userName, String password) async {
    final baseurl = Uri.parse('${(API().baseUrl)}account');
    bool result = false;
    final reponse = await http.get(baseurl);
    List<AccountsModel> parseAccounts(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<AccountsModel>((json) {
        return AccountsModel(
          userName: json['username'],
          password: json['password'],
          idaccount: json['id'],
          serviceid: json['serviceid'],
          // Chuyển đổi số nguyên thành DateTime
          duration:
              DateTime.fromMillisecondsSinceEpoch(json['duration'] * 1000),
        );
      }).toList();
    }

    if (reponse.statusCode == 200) {
      List<AccountsModel> accounts = parseAccounts(reponse.body);
      for (var item in accounts) {
        if (item.userName == userName && item.password == password) {
          print(item.duration);
          result = true;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('name', userName);
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
      print("đã lấy dữ liệu lịch sử xem phim!");
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

  Future<List<historyPurchase>> pushPurchase() async {
    final baseurl = Uri.parse('${API().baseUrl}/historyPurchase');
    List<historyPurchase> lstPurchase = [];
    DateTime currentDate = DateTime.now();
    try {
      final historyPurchaseData = {
        "nameService": "gói cơ bản",
        "price": "180.000 VND",
        "date": currentDate.toIso8601String(),
        "des": "Đăng ký gói",
        "idAccount": "1",
        "id": "1"
      };
      final jsonData = jsonEncode(historyPurchaseData);
      final res = await http.post(
        baseurl,
        body: jsonData,
        headers: {"Content-Type": "application/json"},
      );

      if (res.statusCode == 201) {
        print("Thanh toán thành công");
        // Chỉnh sửa sau này ở đây
      } else {
        print("Thanh toán thất bại");
      }
    } catch (e) {
      print("Error: $e");
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
      print('Đã lấy dữ liệu danh sách');
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

  Future<String> fectdateMoviescontinues(String id, String idname) async {
    final baseurl = Uri.parse(
        'https://662fcdce43b6a7dce310ccfe.mockapi.io/api/v1/Movies_continue');
    final reponse = await http.get(baseurl);
    int countIDlink = 0;
    bool checkmovies = false;
    var takedata = MoviesContinue(idname: null, idmovie: null, times: "0");
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
          checkmovies = true;
          takedata =
              MoviesContinue(idname: idname, idmovie: id, times: item.times);
        }
      }
    } else {}

    return takedata.times.toString();
  }

  Future<Movies> fetchMovieById(String movieID) async {
    final baseurl = Uri.parse(
        'https://662fcdce43b6a7dce310ccfe.mockapi.io/api/v1/Movies/' + movieID);
    final reponse = await http.get(baseurl);
    if (reponse.statusCode == 200) {
      return Movies.fromJson(jsonDecode(reponse.body));
    } else
      throw Exception('Failed to load post');
  }

  Future<void> addMovToHistory(String movieID) async {
    final uri = Uri.parse('${(api.baseUrl)}History');
    var history = History();
    final requestBody = await fetchMovieById(movieID);

    final res = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );
    if (res.statusCode == 200) {
      print("Lưu thành công");
    }
    print('Failed');
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
      print('Đã lấy dữ liệu ngân hàng!');
      banks = parseAccounts(res.body);
    }
    return banks;
  }

  Future<Service?> getServiceByUser(
      String accountId, String name, String price) async {
    try {
      // Lấy thông tin tài khoản từ accountId
      final accountUrl = Uri.parse('${api.baseUrl}account/$accountId');
      final accountResponse = await http.get(accountUrl);

      if (accountResponse.statusCode == 200) {
        // Chuyển đổi dữ liệu từ JSON sang đối tượng AccountsModel
        final accountJson = json.decode(accountResponse.body);
        final account = AccountsModel.fromJson(accountJson);

        // Lấy service id từ thông tin tài khoản
        final serviceId = account.serviceid;
        if (serviceId == null) return null;

        // Lấy thông tin dịch vụ từ service id
        final serviceUrl = Uri.parse('${api.baseUrl}Service/$serviceId');
        final serviceResponse = await http.get(serviceUrl);

        Service service = Service();
        Service ServiceItem(String responseBody) {
          final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
          return parsed
              .map<Service>((json) => Service(
                  id: json['id'],
                  name: json['name'],
                  price: json['price'],
                  img: json['img'],
                  numberDevice: json['numberDevice'],
                  resolution: json['resolution']))
              .toList();
        }

        if (serviceResponse.statusCode == 200) {
          // Chuyển đổi dữ liệu từ JSON sang đối tượng Service
          service = ServiceItem(serviceResponse.body);
          print("giao dịch thành công");
          return service;
        }
      } else {
        throw Exception('Failed to load account');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
    return null;
  }
}
