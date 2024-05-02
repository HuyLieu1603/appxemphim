class Categorys {
  String? nametype;
  int? id;
  Categorys(
      {
      this.nametype,
      this.id,});

  Categorys.fromJson(Map<String, dynamic> json) {
    nametype = json['name'];
    id = json['id'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    
    data['name'] = nametype;
    data['id'] = id;
    return data;
  }
}