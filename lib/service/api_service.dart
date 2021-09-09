//@dart=2.9
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_search_app/model/TrendingMovieModel.dart';
import 'package:movie_search_app/utils/constants.dart';

class APIService {
  static var client = http.Client();
  static Future<List<TrendingMovie>> getSearchedMovie(String movieName) async {
    http.Response response =
        await client.get(Uri.parse("$searchMovie" + movieName));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['results'];
      List<TrendingMovie> _movies = List<TrendingMovie>();
      for (var movie in data) {
        _movies.add(TrendingMovie.fromMap(movie));
      }
      return _movies;
    } else {
      return [];
    }
  }
}
