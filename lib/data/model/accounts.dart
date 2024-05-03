// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
//account đã đăng ký
class AccountsModel {
  String? idaccount;
  String? userName;
  String? password;
  String? serviceid;
  bool? status;

  AccountsModel({
    required this.idaccount,
    required this.password,
    required this.serviceid,
    required this.userName,
    required this.status,
  });
  static AccountsModel accountEmpty() {
    return AccountsModel(
        idaccount: '',
        password: '',
        serviceid: '',
        userName: '',
        status: false);
  }

  factory AccountsModel.fromJson(Map<String, dynamic> json) {
    return AccountsModel(
      idaccount: json['id'],
      userName: json['userName'],
      password: json['password'],
      serviceid: json['serviceid'],
      status: json['status'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = idaccount;
    data['userName'] = userName;
    data['password'] = password;
    data['serviceid'] = serviceid;
    data['status'] = status;

    return data;
  }
}
