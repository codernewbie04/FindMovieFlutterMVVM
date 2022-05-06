class Movie {
  late final String? poster_path;
  late final bool? adult;
  late final String? overview;
  late final String? release_date;
  late final int? id;
  late final String? title;

  Movie(
      {this.poster_path,
      this.adult,
      this.overview,
      this.release_date,
      this.id,
      this.title});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      poster_path: json["poster_path"] != null ? "https://image.tmdb.org/t/p/w200" + json["poster_path"] : '',
      adult: json["adult"] as bool?,
      overview: json["overview"] as String?,
      release_date: json["release_date"] as String?,
      id: json["id"] as int?,
      title: json["title"] as String?,
    );
  }
}
