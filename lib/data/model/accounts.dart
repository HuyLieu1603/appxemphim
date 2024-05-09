// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_import
import 'dart:convert';

//account đã đăng ký
class AccountsModel {
  String idaccount;
  String userName;
  String password;
  String serviceid;
  DateTime duration;

  AccountsModel({
    required this.idaccount,
    required this.password,
    required this.serviceid,
    required this.userName,
    required this.duration,
  });
  static AccountsModel accountEmpty() {
    return AccountsModel(
        idaccount: '',
        password: '',
        serviceid: '',
        userName: '',
        duration: DateTime.now());
  }

  factory AccountsModel.fromJson(Map<String, dynamic> json) {
    return AccountsModel(
      userName: json['userName'],
      password: json['password'],
      serviceid: json['serviceid'],
      duration: json['duration'],
      idaccount: json['id'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['userName'] = userName;
    data['password'] = password;
    data['serviceid'] = serviceid;
    data['duration'] = duration;
    data['id'] = idaccount;
    return data;
  }
}
