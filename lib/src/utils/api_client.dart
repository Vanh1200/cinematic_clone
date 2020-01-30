import 'dart:convert';
import 'dart:io';

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
}
