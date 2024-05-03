import 'dart:convert';

class Bank {
  int id;
  String name;
  String img;
  // contructor
  Bank({
    required this.id,
    required this.name,
    required this.img,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'img': img};
  }

  factory Bank.fromMap(Map<String, dynamic> map) {
    return Bank(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      img: map['img'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Bank.fromJson(String source) => Bank.fromMap(json.decode(source));
}
