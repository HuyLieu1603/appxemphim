// ignore: file_names
class History {
  String? id;
  String? idMovie;
  String? idAccount;
  DateTime? date;
  String? img;

  History({this.id, this.idMovie, this.idAccount, this.date, this.img});

  History.fromJson(Map<String, dynamic> json) {
    idMovie = json['idMovie'];
    idAccount = json['idAccount'];
    date = DateTime.tryParse(json['date']);
    img = json['img'];

    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idMovie'] = idMovie;
    data['idAccount'] = idAccount;
    data['date'] = date;
    data['img'] = img;
    data['id'] = id;
    return data;
  }
}
