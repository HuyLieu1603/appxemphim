class Favorite {
  String? id;
  String? idMovie;
  String? idAccount;

  Favorite({this.id, this.idMovie, this.idAccount});

  Favorite.fromJson(Map<String, dynamic> json) {
    idMovie = json['idMovie'];
    idAccount = json['idAccount'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nameService'] = idMovie;
    data['price'] = idAccount;
    data['id'] = id;
    return data;
  }
}
