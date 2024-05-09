class Service {
  String? id;
  String? name;
  String? price;
  String? img;
  int? numberDevice;
  String? resolution;
  bool isSelected;
  bool isHovered;
  int? duration;
  Service({
    this.id,
    this.name,
    this.price,
    this.img,
    this.numberDevice,
    this.resolution,
    this.duration,
  }) : isSelected = false, isHovered = false;

  Service.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        price = json['price'],
        img = json['img'],
        numberDevice = json['numberDevice'],
        resolution = json['resolution'],
        duration = json['duration'],
        isSelected = false, isHovered = false;

  bool get getIsHovered => isHovered;

  set setIsHovered(bool hovered) {
    isHovered = hovered;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    data['img'] = img;
    data['numberDevice'] = numberDevice;
    data['resolution'] = resolution;
    data['id'] = id;
    data ['duration'] = duration;
    return data;
  }
}