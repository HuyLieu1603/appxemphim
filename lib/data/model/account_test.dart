import 'dart:convert';

class Account{
  
  String? name;
  String? pass;
  String? id;

Account ({this.id , this.name , this.pass});
Account.fromJson(Map<String,dynamic>json){
  
  name = json['name'];
  pass = json['pass'];
  id = json['id'];
}
Map<String,dynamic> toJson(){
    final Map<String,dynamic>data = <String ,dynamic>{};
    
    data['name'] = name;
    data['pass'] = pass;
    data['id'] = id;
    return data;
  }
}