// ignore: camel_case_types
class historyPurchase {
  String? id;
  String? nameService;
  int? price;
  DateTime? date;
  String? des;
  String? idAccount;

  historyPurchase({this.id, this.nameService, this.price, this.date, this.des,this.idAccount});

  historyPurchase.fromJson(Map<String, dynamic> json) {
    nameService = json['nameService'];
    price = json['price'];
    date = json['date'];
    des = json['des'];
    idAccount = json['idAccount'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nameService'] = nameService;
    data['price'] = price;
    data['date'] = date;
    data['des'] = des;
    data['idAccount'] = idAccount;
    data['id'] = id;
    return data;
  }
}
