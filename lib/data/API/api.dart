import 'package:appxemphim/data/model/Favorite/favoriteMovie.dart';
import 'package:appxemphim/data/model/category.dart';
import 'package:appxemphim/data/model/history/historyPurchase.dart';
import 'package:appxemphim/data/model/movielinks.dart';
import 'package:appxemphim/data/model/bank.dart';
import 'package:appxemphim/data/model/movies_continue/movies_continue.dart';
import 'package:appxemphim/data/model/movies_rating/movies_rating.dart';
import 'package:intl/intl.dart';
import 'package:appxemphim/data/model/movies_directors/movies_directors.dart';
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
          serviceid: json['serviceid'],
          // Chuyển đổi số nguyên thành DateTime
          duration: DateTime.parse(json['duration']),
          idaccount: json['id'],
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
          prefs.setString('idaccount', item.idaccount);
          prefs.setString('duration', item.duration.toIso8601String());
          prefs.setString('serviceid', item.serviceid.toString());
        }
      }
    }
    return result;
  }

  Future<AccountsModel> getUserInfo(String userName, String serviceId,
      DateTime duration, String idaccount) async {
    final baseurl = Uri.parse('${(API().baseUrl)}account?id=$idaccount');
    final response = await http.get(baseurl);

    AccountsModel parseAccount(String responseBody) {
      final parsedList = json.decode(responseBody);

      // Ensure that parsedList is actually a List<Map<String, dynamic>>
      if (parsedList is List) {
        // Check if the list is not empty
        if (parsedList.isNotEmpty) {
          // Access the first item in the list
          final parsed = parsedList.first;
          return AccountsModel(
            userName: parsed['username'],
            password: parsed['password'],
            idaccount: parsed['id'],
            serviceid: parsed['serviceid'],
            duration: DateTime.parse(parsed['duration']),
          );
        } else {
          throw Exception('No account found for id: $idaccount');
        }
      } else {
        throw Exception('Invalid response format. Expected a List.');
      }
    }

    if (response.statusCode == 200) {
      return parseAccount(response.body);
    } else {
      print(idaccount);
      throw Exception('Failed to get User Info: ${response.statusCode}');
    }
  }

  Future<List<History>> fetchHistory(String accountID) async {
    final baseurl = Uri.parse('${API().baseUrl}History?idAccount=$accountID');
    final response = await http.get(baseurl);

    if (response.statusCode == 200) {
      List<dynamic> jsonHistories = json.decode(response.body);
      Map<String, History> uniqueHistories = {};

      for (var jsonHistory in jsonHistories) {
        try {
          History history = History.fromJson(jsonHistory);
          String idMovie = history.idMovie ?? '';
          if (!uniqueHistories.containsKey(idMovie) ||
              uniqueHistories[idMovie]!.date!.isBefore(history.date!)) {
            uniqueHistories[idMovie] = history;
          }
        } catch (e) {
          print('Error parsing history: $e');
        }
      }

      // Chuyển các bản ghi từ Map thành List
      List<History> histories = uniqueHistories.values.toList();

      print("Load thành công");

      return histories;
    } else {
      print('Failed to fetch history: ${response.statusCode}');
      return [];
    }
  }

  Future<Movies> fetchMovieById(String movieID) async {
    final baseurl = Uri.parse(
        'https://662fcdce43b6a7dce310ccfe.mockapi.io/api/v1/Movies/$movieID');
    final reponse = await http.get(baseurl, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if (reponse.statusCode == 200) {
      return Movies.fromJson(jsonDecode(reponse.body));
    } else
      throw Exception('Failed to load post');
  }

//Lưu phim đã xem vào history
  Future<void> addMovToHistory(String movieID) async {
    final requestBody = await fetchMovieById(movieID);

    final uri = Uri.parse('${(API().baseUrl)}History');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('name').toString());
    var history = History(
      idMovie: movieID,
      idAccount: prefs.getString('name').toString(),
      date: DateTime.now(),
      img: requestBody.img,
      nameMovie: requestBody.name,
      type: requestBody.type,
    );

    Map<String, dynamic> historyJson = {
      'idMovie':
          history.idMovie, // Sử dụng thể hiện history để truy cập idMovie
      'idAccount': history.idAccount,
      'date': history.date!.toIso8601String(),
      'nameMovie': history.nameMovie,
      'type': history.type,
      'img': history.img,
    };

    String historyJsonString = jsonEncode(historyJson);
    print(history);
    final res = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: historyJsonString,
    );
    if (res.statusCode == 200) {
      print("Lưu thành công");
    }
    print('Failed');
  }

  Future<List<historyPurchase>> fetchPurchase(String accountID) async {
    final baseurl =
        Uri.parse('${API().baseUrl}/historyPurchase'); // Sửa đường dẫn URL
    List<historyPurchase> lstPurchase = [];
    List<historyPurchase> lstHistory(String respondbody) {
      final parsed = json.decode(respondbody).cast<Map<String, dynamic>>();
      return parsed
          .map<historyPurchase>((json) => historyPurchase(
                nameService: json['nameService'],
                price: json['price'],
                date: DateTime.parse(
                    json['date']), // Chuyển đổi sang kiểu DateTime
                des: json['des'],
                idAccount: json['idAccount'],
                id: json['id'],
              ))
          .toList();
    }

    try {
      final res = await http.get(baseurl);

      if (res.statusCode == 200) {
        lstPurchase = lstHistory(res.body);
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String idAccount = prefs.getString('idaccount') ?? '';
    String serviceName = prefs.getString('servicename') ?? '';
    String servicePrice = prefs.getString('serviceprice') ?? '';

    DateTime currentDate = DateTime.now();
    try {
      final historyPurchaseData = {
        "nameService": serviceName,
      "price": servicePrice,
      "date": currentDate.toIso8601String(),
      "des": "Dìa día",
      "idAccount": idAccount
      };
      final jsonData = jsonEncode(historyPurchaseData);
      final res = await http.post(
        baseurl,
        body: jsonData,
        headers: {"Content-Type": "application/json"},
      );

      if (res.statusCode == 201) {
        print("Thanh toán thành công");
      } else {
        print("Thanh toán thất bại");
      }
    } catch (e) {
      print("Error: $e");
    }
    throw Exception('Failed to push purchase');
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
      print('đã lấy dữ liệu ngân hàng!');
      banks = parseAccounts(res.body);
    }
    return banks;
  }

  Future<Service> getServiceByUser(
      String serviceId, String name, String price, String img) async {
    try {
      final serviceUrl = Uri.parse('${api.baseUrl}Service/$serviceId');
      final serviceResponse = await http.get(serviceUrl);

      if (serviceResponse.statusCode == 200) {
        final serviceJson = json.decode(serviceResponse.body);

        // Create a Service object directly from the decoded JSON
        var service = Service.fromJson(serviceJson);

        // Store service information in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('servicename', service.name);
        prefs.setString('serviceprice', service.price.toString());
        prefs.setString('serviceresolution', service.resolution);
        prefs.setString('numberdevice', service.numberDevice.toString());
        prefs.setString('serviceimg', service.img);

        print("Đã lấy dữ liệu service từ id khách hàng");
        return service;
      } else {
        throw Exception('Failed to load service');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> extendService(String idaccount, DateTime duration) async {
    final baseUrl = Uri.parse('${API().baseUrl}account/$idaccount');

    // Encode the duration as JSON
    final jsonData = jsonEncode({'duration': duration.toIso8601String()});

    // Send the PUT request to the API to update the account
    final response = await http.put(
      baseUrl,
      body: jsonData,
      headers: {"Content-Type": "application/json"},
    );

    print(duration);

    if (response.statusCode != 200) {
      throw Exception('Gia hạn thất bại!, StatusCode: ${response.statusCode}');
    }
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

  //add
  Future<void> insertFavorite(String movieID) async {
    final requestBody = await fetchMovieById(movieID);
    final baseurl = Uri.parse('${(API().baseUrl)}Favorite');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('name').toString());
    var fav = Favorite(
      idMovie: movieID,
      idAccount: prefs.getString('name').toString(),
      nameMovie: requestBody.name,
      img: requestBody.img,
    );

    Map<String, dynamic> favJson = {
      'idMovie': fav.idMovie,
      'idAccount': fav.idAccount,
      'nameMovie': fav.nameMovie,
      'img': fav.img,
    };

    String favJsonString = jsonEncode(favJson);
    final response = await http.post(
      baseurl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: favJsonString,
    );
    if (response.statusCode == 201) {
      print('Thêm thành công yêu thích');
    } else {
      print('Failed: ${response.statusCode}');
    }
  }

  Future<void> deleteFavorite(String idMovie, String idAccount) async {
    int locate = 1;
    bool findlocate = false;
    try {
      final baseurl = Uri.parse('${(API().baseUrl)}Favorite');
      print(baseurl);
      final reponse = await http.get(baseurl);
      List<Favorite> lstFavorite = [];
      List<Favorite> parseAccounts(String responseBody) {
        final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
        return parsed
            .map<Favorite>((json) => Favorite(
                  idMovie: json['idMovie'],
                  idAccount: json['idAccount'],
                  nameMovie: json['nameMovie'],
                  img: json['img'],
                  id: json['id'],
                ))
            .toList();
      }

      if (reponse.statusCode == 200) {
        // print("ok");
        lstFavorite = parseAccounts(reponse.body);

        //vong lap lay locate
        for (var item in lstFavorite) {
          if (item.idMovie == idMovie && item.idAccount == idAccount) {
            findlocate = true;
            break;
          } else {
            if (lstFavorite.length > locate) {
              locate += 1;
            }
          }
        }
      } else {
        print('Lỗi: ${reponse.statusCode}');
      }
      if (findlocate == true) {
        final baseurls =
            Uri.parse('${(API().baseUrl)}Favorite/' + locate.toString().trim());
        print(baseurls);
        final response = await http.delete(
          baseurls,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );

        if (response.statusCode == 200) {
          print('Xóa yêu thích thành công');
        } else {
          print('Lỗi: ${response.statusCode}');
        }
      } else {
        print('đéo có gì để xóa');
      }

      /*
      final response = await http.delete(
        baseurl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      
      if (response.statusCode == 200) {
        print('Xóa yêu thích thành công');
      } else {
        print('Lỗi: ${response.statusCode}');
      }*/
    } catch (error) {
      print('Lỗi khi thực hiện yêu cầu DELETE: $error');
    }
  }

  Future<bool> checkFav(String idMovie) async {
    bool check = false;
    final baseurl = Uri.parse('${(API().baseUrl)}Favorite?idMovie=$idMovie');
    final res = await http.get(baseurl);
    if (res.statusCode == 200) {
      List<dynamic> jsonFav = jsonDecode(res.body);
      List<Favorite> lstFav =
          jsonFav.map((json) => Favorite.fromJson(json)).toList();
      if (lstFav.isNotEmpty) {
        check = true;
      }
    }
    return check;
  }

  Future<List<Favorite>> fetchFav(String idAccount) async {
    final baseurl = Uri.parse('${(API().baseUrl)}Favorite');
    final res = await http.get(baseurl);
    if (res.statusCode == 200) {
      Iterable jsonResponse = jsonDecode(res.body);
      print(jsonResponse);
      return jsonResponse
          .map((favorite) => Favorite.fromJson(favorite))
          .toList();
    } else {
      throw Exception('Failed to load favorites');
    }
  }

  Future<MoviesDirector> fectchMoviesDirector(String id) async {
    final baseurl = Uri.parse(
        'https://662fcdce43b6a7dce310ccfe.mockapi.io/api/v1/Movies/' +
            id.toString().trim() +
            '/Movies_Director');
    print(baseurl);
    final reponse = await http.get(baseurl);
    List<MoviesDirector> lstMoviesDirector = [];
    List<MoviesDirector> parseAccounts(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed
          .map<MoviesDirector>((json) => MoviesDirector(
                Director: json['Director'],
                Actor: json['Actor'],
                id: json['id'],
                MovieId: json['MovieId'],
              ))
          .toList();
    }

    if (reponse.statusCode == 200) {
      // print("ok");
      lstMoviesDirector = parseAccounts(reponse.body);

      return lstMoviesDirector[0];
    } else {
      print("false");
    }
    return lstMoviesDirector[0];
  }

  Future<bool> fectMoviesRating(
      String idname, String idmovies, String ratings) async {
    bool check = false;
    //kiem tra co trong danh sach phim hya khong voi idname va id movies
    final baseurl =
        Uri.parse('${(API().baseUrl)}Movies/' + idmovies + "/Movies_rating");
    //print(baseurl);
    final reponse = await http.get(baseurl);
    List<MoviesRating> lstRating = [];
    List<MoviesRating> parseAccounts(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed
          .map<MoviesRating>((json) => MoviesRating(
                idname: json['idname'],
                idmovies: json['idmovies'],
                rating: json['rating'],
                id: json['id'],
                MovieId: json['MovieId'],
              ))
          .toList();
    }

    if (reponse.statusCode == 200) {
      //print("ok");
      lstRating = parseAccounts(reponse.body);
      MoviesRating items = MoviesRating();
      int index = lstRating.indexWhere(
          (rating) => rating.idname == idname && rating.idmovies == idmovies);

      for (var rating in lstRating) {
        if (rating.idname == idname && rating.idmovies == idmovies) {
          items = rating;
          items.rating = ratings;
          break;
        }
      }

      if (index != -1) {
        // print(items);
        print(
            'Rating exists at index $index for idname: $idname and idmovies: $idmovies');
        var url = Uri.parse('${(API().baseUrl)}Movies/' +
            items.id.toString() +
            "/Movies_rating/" +
            items.id.toString());
        print(url);
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
          print('Rating Updated successfully');
        } else {
          // Handle errors
          print('Error: ${response.statusCode}');
        }
      } else {
        print(
            'Rating does not exist for idname: $idname and idmovies: $idmovies');
        var urlpost = Uri.parse('${(API().baseUrl)}Movies_rating');
        Map<String, dynamic> rateJson = {
          'idname': idname.toString(),
          'idmovies': idmovies.toString(),
          'rating': ratings,
          'MovieId': idmovies.toString(),
        };
        String rateJsonString = jsonEncode(rateJson);
        final response = await http.post(
          urlpost,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: rateJsonString,
        );
        if (response.statusCode == 201) {
          print('Thêm thành công rating');
        } else {
          print('Failed: ${response.statusCode}');
        }
      }
    } else {
      print(
          'Rating does not exist for idname: $idname and idmovies: $idmovies');
      var urlpost = Uri.parse('${(API().baseUrl)}Movies_rating');
      Map<String, dynamic> rateJson = {
        'idname': idname.toString(),
        'idmovies': idmovies.toString(),
        'rating': ratings,
        'MovieId': idmovies.toString(),
      };
      String rateJsonString = jsonEncode(rateJson);
      final response = await http.post(
        urlpost,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: rateJsonString,
      );
      if (response.statusCode == 201) {
        print('Thêm thành công rating');
      } else {
        print('Failed: ${response.statusCode}');
      }
      //print('Lỗi: ${reponse.statusCode}');
    }

    return check;
  }

  Future<String> fectdataMoviesRating(String idname, String idmovies) async {
    String check = "0";
    //kiem tra co trong danh sach phim hya khong voi idname va id movies
    final baseurl =
        Uri.parse('${(API().baseUrl)}Movies/' + idmovies + "/Movies_rating");
    final reponse = await http.get(baseurl);
    List<MoviesRating> lstRating = [];
    List<MoviesRating> parseAccounts(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed
          .map<MoviesRating>((json) => MoviesRating(
                idname: json['idname'],
                idmovies: json['idmovies'],
                rating: json['rating'],
                id: json['id'],
                MovieId: json['MovieId'],
              ))
          .toList();
    }

    if (reponse.statusCode == 200) {
      lstRating = parseAccounts(reponse.body);
      for (var rating in lstRating) {
        if (rating.idname == idname && rating.idmovies == idmovies) {
          check = rating.rating.toString().trim();

          break;
        }
      }
    } else {
      return check;
    }
    return check;
  }

  Future<String> fecttotalidMoviesRating(String idmovies) async {
    int total = 0;
    int count = 0;
    double result = 0.0;
    String check = "0";
    //kiem tra co trong danh sach phim hya khong voi idname va id movies
    final baseurl =
        Uri.parse('${(API().baseUrl)}Movies/' + idmovies + "/Movies_rating");
    final reponse = await http.get(baseurl);
    List<MoviesRating> lstRating = [];
    List<MoviesRating> parseAccounts(String responseBody) {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed
          .map<MoviesRating>((json) => MoviesRating(
                idname: json['idname'],
                idmovies: json['idmovies'],
                rating: json['rating'],
                id: json['id'],
                MovieId: json['MovieId'],
              ))
          .toList();
    }

    if (reponse.statusCode == 200) {
      lstRating = parseAccounts(reponse.body);
      for (var rating in lstRating) {
        if (rating.idmovies == idmovies) {
          total += int.parse(rating.rating.toString().trim());
          count += 1;
        }
      }
      result = (total / count) + (total % count);
      check = result.toString();
    } else {
      return check;
    }
    return check;
  }
}
