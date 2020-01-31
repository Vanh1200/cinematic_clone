import 'package:cinematic_clone/src/model/movie.dart';
import 'package:cinematic_clone/src/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  MovieRepository _movieRepository;

  HomeBloc(MovieRepository movieRepository) {
    _movieRepository = movieRepository;
  }

  PublishSubject _moviesPopularSubject = PublishSubject<List<Movie>>();

  PublishSubject _moviesUpcomingSubject = PublishSubject<List<Movie>>();

  PublishSubject _moviesTopRatedSubject = PublishSubject<List<Movie>>();

  Stream get moviesPopularStream => _moviesPopularSubject.stream;

  Stream get moviesUpcomingStream => _moviesUpcomingSubject.stream;

  Stream get moviesTopRatedStream => _moviesTopRatedSubject.stream;

  List<Movie> moviesPopular = List();

  List<Movie> moviesUpcoming = List();

  List<Movie> moviesTopRated = List();

  fetchMovies(String category, {int page: 1}) async {
    print("fetch movies type: $category");
    try {
      var movies = await _movieRepository.loadMovies(category, page: page);
      switch (category) {
        case "popular":
          moviesPopular.addAll(movies);
          _moviesPopularSubject.sink.add(moviesPopular);
          break;
        case "upcoming":
          moviesUpcoming.addAll(movies);
          _moviesUpcomingSubject.sink.add(moviesUpcoming);
          break;
        case "top_rated":
          moviesTopRated.addAll(movies);
          _moviesTopRatedSubject.sink.add(moviesTopRated);
          break;
      }
    } catch (exception) {
      _moviesPopularSubject.sink.addError(exception.toString());
    }
  }

  void dispose() {
    _moviesPopularSubject.close();
    _moviesUpcomingSubject.close();
    _moviesTopRatedSubject.close();
  }
}
