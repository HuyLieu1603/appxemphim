class Signup {
  String? username;
  String? password;
  String? serviceid;
int? duration;
  Signup({ this.username, this.password, this.serviceid, this.duration });
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'serviceid': serviceid,
      'duration': duration,
    };
  }
}
