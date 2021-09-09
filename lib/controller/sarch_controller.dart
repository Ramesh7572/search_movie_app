//@dart=2.9
import 'package:get/state_manager.dart';
import 'package:movie_search_app/model/TrendingMovieModel.dart';
import 'package:movie_search_app/service/api_service.dart';

class MovieController extends GetxController {
  var isLoading = false.obs;
  List<TrendingMovie> searchedMovies = List<TrendingMovie>().obs;
  void getSearchedMovie(String movieName) async {
    isLoading(true);
    var _movies = await APIService.getSearchedMovie(movieName);
    if (_movies != null) {
      searchedMovies = _movies;
    }
    isLoading(false);
  }
}
