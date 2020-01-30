import 'package:cinematic_clone/src/utils/utils.dart';

class Movie {
  int id;
  double voteAverage;
  String title;
  String posterPath;
  String backdropPath;
  String overview;
  String releaseDate;
  List<int> genreIds;

  String getBackDropUrl() => getLargePictureUrl(backdropPath);

  String getPosterUrl() => getMediumPictureUrl(posterPath);

  int getReleaseYear() {
    return releaseDate == null || releaseDate == ""
        ? 0
        : DateTime.parse(releaseDate).year;
  }

  Movie.fromMap(Map<String, dynamic> jsonMap) :
    id = jsonMap["id"].toInt(),
    voteAverage = jsonMap["vote_average"].toDouble(),
    title = jsonMap["title"],
    posterPath = jsonMap["poster_path"] ?? "",
    backdropPath = jsonMap["backdrop_path"] ?? "",
    overview = jsonMap["overview"],
    releaseDate = jsonMap["release_date"],
    genreIds = (jsonMap["genre_ids"] as List<dynamic>)
        .map<int>((value) => value.toInt())
        .toList();

}