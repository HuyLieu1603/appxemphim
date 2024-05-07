// ignore: file_names
class History {
  String? id;
  String? idMovie;
  String? idAccount;
  DateTime? date;
  String? img;
  String? nameMovie;
  Object? type;

  History(
      {this.id,
      this.idMovie,
      this.idAccount,
      this.date,
      this.img,
      this.nameMovie,
      this.type});

  History.fromJson(Map<String, dynamic> json) {
    idMovie = json['idMovie'];
    idAccount = json['idAccount'];
    date = DateTime.tryParse(json['date']);
    img = json['img'];
    nameMovie = json['nameMovie'];
    type = json['type'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idMovie'] = idMovie;
    data['idAccount'] = idAccount;
    data['date'] = date;
    data['img'] = img;
    data['nameMovie'] = nameMovie;
    data['type'] = type;
    data['id'] = id;
    return data;
  }
}
