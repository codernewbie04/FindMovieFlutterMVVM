import 'package:belajar_flutter/model/movie.dart';
import 'package:belajar_flutter/model/services/base_service.dart';
import 'package:belajar_flutter/model/services/movie_service.dart';

class MovieRepository {
  BaseService _movieService = MovieService();

  Future<List<Movie>> fetchMovieList(String value) async {
    dynamic response = await _movieService.getResponse(value);
    final jsonData = response['results'] as List;
    List<Movie> movieList =
        jsonData.map((tagJson) => Movie.fromJson(tagJson)).toList();
    return movieList;
  }
}
