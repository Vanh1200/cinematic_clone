import 'package:cinematic_clone/src/model/movie.dart';
import 'package:cinematic_clone/src/utils/api_client.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  ApiClient _apiClient;

  HomeBloc(ApiClient apiClient) {
    _apiClient = apiClient;
  }

  PublishSubject _moviesSubject = PublishSubject<List<Movie>>();

  Stream get moviesStream => _moviesSubject.stream;

  fetchMovies(String category, {int page: 1}) async {
    var movies = await _apiClient.fetchMovies(category: category, page: page);
    _moviesSubject.sink.add(movies);
  }

  void dispose() {
    _moviesSubject.close();
  }
}