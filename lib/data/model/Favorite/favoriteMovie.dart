class Favorite {
  String? id;
  String? idMovie;
  String? idAccount;
  String? nameMovie;
  String? img;

  Favorite({this.id, this.idMovie, this.idAccount, this.nameMovie, this.img});

  Favorite.fromJson(Map<String, dynamic> json) {
    idMovie = json['idMovie'];
    idAccount = json['idAccount'];
    nameMovie = json['nameMovie'];
    img = json['img'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idMovie'] = idMovie;
    data['idAccount'] = idAccount;
    data['nameMovie'] = nameMovie;
    data['img'] = img;
    data['id'] = id;
    return data;
  }
}
