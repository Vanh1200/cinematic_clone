import 'package:cinematic_clone/src/model/cast.dart';
import 'package:cinematic_clone/src/model/movie.dart';
import 'package:cinematic_clone/src/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailBloc {
  MovieRepository _movieDetailRepository;

  MovieDetailBloc(this._movieDetailRepository);

  PublishSubject _movieDetailSubject = PublishSubject<dynamic>();

  PublishSubject _movieCreditsSubject = PublishSubject<List<Actor>>();

  PublishSubject _similarMoviesSubject = PublishSubject<List<Movie>>();

  Stream get movieDetailStream => _movieDetailSubject.stream;

  Stream get movieCreditsStream => _movieCreditsSubject.stream;

  Stream get similarMoviesStream => _similarMoviesSubject.stream;

  getMovieDetail(String id) async {
    print("get movie detail id: $id");
    try {
      dynamic movieDetail = await _movieDetailRepository.loadMovieDetail(id);
      _movieDetailSubject.sink.add(movieDetail);
    } catch (exception) {
      //todo catch exception later
    }
  }

  getMovieCasts(String id) async {
    print("get movie casts id: $id");
    try {
      List<Actor> actors = await _movieDetailRepository.loadMovieCredits(id);
      _movieCreditsSubject.sink.add(actors);
    } catch (exception) {
      //todo catch exception later
    }
  }

  getSimilarMovies(String id) async {
    print("get similar movies id: $id");
    try {
      List<Movie> movies = await _movieDetailRepository.loadSimilarMovies(id);
      _similarMoviesSubject.sink.add(movies);
    } catch (exception) {
      //todo catch exception later
    }
  }

  void dispose() {
    _movieDetailSubject.close();
    _movieCreditsSubject.close();
    _similarMoviesSubject.close();
  }
}
