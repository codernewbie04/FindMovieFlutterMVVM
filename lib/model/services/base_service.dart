abstract class BaseService   {
  static const String apikey = "xxxxxxxxxxxxxxx"; // put your apikey themoviedb in here
  final String baseUrl = 'https://api.themoviedb.org/3/search/movie?api_key=$apikey&page=1&include_adult=true&query=';

  Future<dynamic> getResponse(String url);

}