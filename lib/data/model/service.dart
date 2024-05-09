class Service {
  String id;
  String name;
  int price;
  String img;
  int numberDevice;
  String resolution;
  bool isSelected;

  Service({
    required this.id,
    required this.name,
    required this.price,
    required this.img,
    required this.numberDevice,
    required this.resolution,
  }) : isSelected = false;

  Service.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        price = json['price'],
        img = json['img'],
        numberDevice = json['numberDevice'],
        resolution = json['resolution'],
        isSelected = false;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    data['img'] = img;
    data['numberDevice'] = numberDevice;
    data['resolution'] = resolution;
    data['id'] = id;
    return data;
  }
}