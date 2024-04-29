import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Login {
  int? id;
  String? userName;
  String? passWord;
  String? img;
  
  Login({
    this.id,
    this.userName,
    this.passWord,
    this.img,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userName': userName,
      'passWord': passWord,
      'img': img,
    };
  }

  factory Login.fromMap(Map<String, dynamic> map) {
    return Login(
      id: map['id'] != null ? map['id'] as int : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      passWord: map['passWord'] != null ? map['passWord'] as String : null,
      img: map['img'] != null ? map['img'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Login.fromJson(String source) => Login.fromMap(json.decode(source) as Map<String, dynamic>);
}
