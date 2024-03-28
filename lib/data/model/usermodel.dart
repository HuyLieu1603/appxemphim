class User {
  String? sothe;
  String? tenchuthe;
  String? ngayphathanh;

  //constructor named
  User({
    this.sothe,
    this.tenchuthe,
    this.ngayphathanh,
  });

  User.fromJson(Map<String, dynamic> json) {
    sothe = json['sothe'];
    tenchuthe = json['tenchuthe'];
    ngayphathanh = json['ngayphathanh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sothe'] = sothe;
    data['tenchuthe'] = tenchuthe;
    data['ngayphathanh'] = ngayphathanh;
    return data;
  }
}