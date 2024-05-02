// ignore: file_names
class History {
  String? id;
  String? idMovie;
  String? idAccount;
  DateTime? date;

  History({this.id, this.idMovie, this.idAccount, this.date});

  History.fromJson(Map<String, dynamic> json) {
    idMovie = json['idMovie'];
    idAccount = json['idAccount'];
    date = json['date'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idMovie'] = idMovie;
    data['idAccount'] = idAccount;
    data['date'] = date;
    data['id'] = id;
    return data;
  }
}
