class MoviesContinue {
  //String? id;
  String? idname;
  String? idmovie;
  String? times;
  MoviesContinue(
      {
      //this.id,
      this.idname,
      this.idmovie,
      this.times,
      });

  MoviesContinue.fromJson(Map<String, dynamic> json) {
   
    //id = json['id'];
    idname = json['idname'];
    idmovie = json['idmovie'];
    times = json['times'];
    
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    
    //data['id'] = id;
    data['idname'] = idname;
    data['idmovie'] = idmovie;
    data['times'] = times;
    
    return data;
  }
}