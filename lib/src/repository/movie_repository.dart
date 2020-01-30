import 'package:cinematic_clone/src/model/movie.dart';
import 'package:cinematic_clone/src/utils/api_client.dart';

abstract class MovieRemoteDataSource {
  Future<List<Movie>> loadMovies(String category, {int page: 1});
}

class MovieRepository implements MovieRemoteDataSource {
  MovieRepository();

  ApiClient _apiClient = ApiClient();

  @override
  Future<List<Movie>> loadMovies(String category, {int page = 1}) {
    return _apiClient.fetchMovies(category: category, page: page);
  }
}
