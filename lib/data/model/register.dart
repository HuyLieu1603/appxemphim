class Signup {
  String? username;
  String? password;
  String? serviceid;

  Signup({ this.username, this.password, this.serviceid});
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'serviceid': serviceid,
    };
  }
}
