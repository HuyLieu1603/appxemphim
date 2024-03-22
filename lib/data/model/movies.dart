class Movies {
  int? id;
  String? name;
  String? img;
  Object? type;
  String? des;
  String? release;
  String? time;

  Movies(
      {this.id,
      this.name,
      this.img,
      this.type,
      this.des,
      this.release,
      this.time});

  Movies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    type = json['type'];
    des = json['des'];
    release = json['release'];
    time = json['time'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['img'] = img;
    data['type'] = type;
    data['des'] = des;
    data['release'] = release;
    data['time'] = time;
    return data;
  }
}