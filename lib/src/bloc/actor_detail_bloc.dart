import 'package:cinematic_clone/src/model/movie.dart';
import 'package:cinematic_clone/src/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class ActorDetailBloc {
  MovieRepository _movieRepository;

  ActorDetailBloc(this._movieRepository);

  PublishSubject _moviesOfActorSubject = PublishSubject<List<Movie>>();

  PublishSubject _moviesOfActorSubject2 = PublishSubject<List<Movie>>();

  Stream get moviesOfActorStream => _moviesOfActorSubject.stream;

  Stream get moviesOfActorStream2 => _moviesOfActorSubject2.stream;

  getMoviesOfActor(String actorId) async {
    print("get movies for actor id: $actorId");
    try {
      List<Movie> movies = await _movieRepository.loadMoviesOfActor(actorId);
      _moviesOfActorSubject.sink.add(movies);
    } catch (exception) {
      //todo catch exception later
    }
  }

  getMoviesOfActor2(String actorId) async {
    print("get movies2 for actor id: $actorId");
    try {
      List<Movie> movies = List();
      movies = await _movieRepository.loadMoviesOfActor(actorId);
      _moviesOfActorSubject2.sink.add(movies);
    } catch (exception) {
      //todo catch exception later
    }
  }

  void dispose() {
    _moviesOfActorSubject.close();
    _moviesOfActorSubject2.close();
  }
}
