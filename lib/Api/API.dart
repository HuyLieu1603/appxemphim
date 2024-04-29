import 'package:appxemphim/data/model/account_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


Future<bool> fetchdata(String name , String pass)async{
  final baseurl = Uri.parse('https://6629a5d367df268010a13cf2.mockapi.io/api/v1/user');
  //String baseurl = "https://6629a5d367df268010a13cf2.mockapi.io/api/v1";
  bool result = false ;
  final reponse = await http.get(baseurl);
  List<Account> parseAccounts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Account>((json) => Account(
        name: json['name'],
        pass: json['pass'],
        id: json['id'],
      )).toList();
}
  if(reponse.statusCode == 200){
    List<Account> accounts = parseAccounts(reponse.body);
    for(var item in accounts){
      if(item.name == name && item.pass == pass){
        result = true;
      }
    }
  }
  return result;
}