class Movies {
  String? name;
  String? img;
  Object? type;
  String? des;
  String? release;
  String? time;
  String? category;
  String? id;
  Movies(
      {
      this.name,
      this.img,
      this.type,
      this.des,
      this.release,
      this.time,this.category,this.id,});

  Movies.fromJson(Map<String, dynamic> json) {
   
    name = json['name'];
    img = json['img'];
    type = json['type'];
    des = json['des'];
    release = json['release'];
    time = json['time'];
    category = json['category'];
    id = json['id'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    
    data['name'] = name;
    data['img'] = img;
    data['type'] = type;
    data['des'] = des;
    data['release'] = release;
    data['time'] = time;
    data['category'] = category;
    data['id'] = id;
    return data;
  }
}