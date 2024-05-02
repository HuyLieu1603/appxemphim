// ignore: camel_case_types
class historyPurchase {
  String? id;
  String? nameService;
  double? price;
  DateTime? date;
  String? des;

  historyPurchase({this.id, this.nameService, this.price, this.date, this.des});

  historyPurchase.fromJson(Map<String, dynamic> json) {
    nameService = json['nameService'];
    price = json['price'];
    date = json['date'];
    des = json['des'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nameService'] = nameService;
    data['price'] = price;
    data['date'] = date;
    data['des'] = des;
    data['id'] = id;
    return data;
  }
}
