import 'dart:convert';
import 'dart:io';

import 'package:cinematic_clone/src/model/cast.dart';
import 'package:cinematic_clone/src/model/movie.dart';
import 'package:cinematic_clone/src/utils/constants.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl = "api.themoviedb.org";
  final JsonDecoder _decoder = new JsonDecoder();

  static final _instance = ApiClient._internal();

  factory ApiClient() => _instance;

  ApiClient._internal();

  Future<List<Movie>> fetchMovies(
      {String category: "popular", int page: 1}) async {
    var url = Uri.https(baseUrl, '3/movie/$category',
        {'api_key': API_KEY, 'page': page.toString()});
    var response = await http.get(url);
    if (response.statusCode != 200 || response == null) {
      throw new HttpException(
          "fetch movie false, status code: ${response.statusCode}");
    } else {
      print(response);
      final movieItems = _decoder.convert(response.body)['results'] as List;
      return movieItems.map((movieMap) => Movie.fromMap(movieMap)).toList();
    }
  }

  Future<List<Movie>> getSimilarMedia(int id, {String type: "movie"}) async {
    var url = Uri.https(baseUrl, '3/$type/$id/similar', {
      'api_key': API_KEY,
    });
    var response = await http.get(url);
    if (response.statusCode != 200 || response == null) {
      throw new HttpException(
          "get similar movie of $id false, status code: ${response.statusCode}");
    } else {
      print(response);
      final movieItems = _decoder.convert(response.body)['results'] as List;
      return movieItems.map((movieMap) => Movie.fromMap(movieMap)).toList();
    }
  }

  Future<List<Actor>> getMovieCredits(int id, {String type: "movie"}) async {
    var url = Uri.https(baseUrl, '3/$type/$id/credits', {'api_key': API_KEY});
    var response = await http.get(url);
    if (response.statusCode != 200 || response == null) {
      throw new HttpException(
          "get similar movie of $id false, status code: ${response.statusCode}");
    } else {
      print(response);
      final actors = _decoder.convert(response.body)['cast'] as List;
      return actors.map((actor) => Actor.fromMap(actor)).toList();
    }
  }

  Future<dynamic> getMovieDetail(int id, {String type: "movie"}) async {
    var url = Uri.https(baseUrl, '3/$type/$id', {'api_key': API_KEY});
    var response = await http.get(url);
    if (response.statusCode != 200 || response == null) {
      throw new HttpException(
          "get detail of $id false, status code: ${response.statusCode}");
    } else {
      print(response);
      return _decoder.convert(response.body);
    }
  }
}
