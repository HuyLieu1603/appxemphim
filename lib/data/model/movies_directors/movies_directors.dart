class MoviesDirector {
  //String? id;
  String? Director;
  Object? Actor;
  String? id;
  String? MovieId;
  MoviesDirector({
    //this.id,
    this.Director,
    this.Actor,
    this.id,
    this.MovieId,
  });

  MoviesDirector.fromJson(Map<String, dynamic> json) {
    //id = json['id'];
    Director = json['Director'];
    Actor = json['Actor'];
    id = json['id'];
    MovieId = json['MovieId'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    //data['id'] = id;
    data['Director'] = Director;
    data['Actor'] = Actor;
    data['id'] = id;
    data['MovieId'] = MovieId;
    return data;
  }
}
