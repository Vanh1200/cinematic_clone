import 'package:cinematic_clone/src/model/cast.dart';
import 'package:cinematic_clone/src/model/movie.dart';
import 'package:cinematic_clone/src/utils/api_client.dart';

abstract class MovieRemoteDataSource {
  Future<List<Movie>> loadMovies(String category, {int page: 1});

  Future<List<Movie>> loadSimilarMovies(String id);

  Future<dynamic> loadMovieDetail(String id);

  Future<List<Actor>> loadMovieCredits(String id);
}

class MovieRepository implements MovieRemoteDataSource {
  MovieRepository();

  ApiClient _apiClient = ApiClient();

  @override
  Future<List<Movie>> loadMovies(String category, {int page = 1}) {
    return _apiClient.fetchMovies(category: category, page: page);
  }

  @override
  Future<List<Actor>> loadMovieCredits(String id) {
    return _apiClient.getMovieCredits(int.parse(id));
  }

  @override
  Future<dynamic> loadMovieDetail(String id) {
    return _apiClient.getMovieDetail(int.parse(id));
  }

  @override
  Future<List<Movie>> loadSimilarMovies(String id) {
    return _apiClient.getSimilarMedia(int.parse(id));
  }
}
