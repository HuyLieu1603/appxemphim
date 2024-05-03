class MovieLink {
  String? link;
  String? idmovie;
  String? id;
  String? movieId;
  MovieLink(
      {
      this.link,
      this.idmovie,
      this.id,
      this.movieId,
      });

  MovieLink.fromJson(Map<String, dynamic> json) {
   
    link = json['link'];
    idmovie = json['idmovie'];
    id = json['id'];
    movieId = json['movieId'];
    
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    
    data['link'] = link;
    data['idmovie'] = idmovie;
    data['id'] = id;
    data['movieId'] = movieId;
    
    return data;
  }
}