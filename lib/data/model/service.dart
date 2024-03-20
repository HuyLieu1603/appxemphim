class Service {
  int? id;
  String? name;
  int? price;
  String? img;
  int? numberDevice;
  String? resolution;

  Service(
      {this.id,
      this.name,
      this.price,
      this.img,
      this.numberDevice,
      this.resolution});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    numberDevice = json['numberDevice'];
    resolution = json['resolution'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['img'] = img;
    data['numberDevice'] = numberDevice;
    data['resolution'] = resolution;
    return data;
  }
}
