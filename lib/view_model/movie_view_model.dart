
import 'package:belajar_flutter/model/api/api_response.dart';
import 'package:belajar_flutter/model/movie.dart';
import 'package:belajar_flutter/model/movie_repository.dart';
import 'package:flutter/cupertino.dart';



class MovieViewModel with ChangeNotifier{
  Movie? _movie;
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');

  ApiResponse get response {
    return _apiResponse;
  }

  Movie? get movie {
    return _movie;
  }

  Future<void> fetchMovieData(String value) async {
    _apiResponse = ApiResponse.loading('Fetching artist data');
    notifyListeners();
    try {
      List<Movie> movieList = await MovieRepository().fetchMovieList(value);
      _apiResponse = ApiResponse.completed(movieList);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }

  void setSelectedMovie(Movie? movie) {
    _movie = movie;
    notifyListeners();
  }


}