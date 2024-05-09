class MoviesRating {
  String? idname;
  String? idmovies;
  String? rating;
  String? id;
  String? MovieId;//node cha để nhận biết node con

  MoviesRating({this.idname, this.idmovies, this.rating, this.id,this.MovieId});

  MoviesRating.fromJson(Map<String, dynamic> json) {
    idname = json['idname'];
    idmovies = json['idmovies'];
    rating = json['rating'];
    id = json['id'];
    MovieId = json['MovieId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idname'] = idname;
    data['idmovies'] = idmovies;
    data['rating'] = rating;
    data['id'] = id;
    data['MovieId'] = MovieId;
    return data;
  }
}