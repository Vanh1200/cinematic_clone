import 'package:cinematic_clone/src/model/movie.dart';
import 'package:cinematic_clone/src/screen/detail/movie_detail_screen.dart';
import 'package:flutter/material.dart';

goToMovieDetails(BuildContext context, Movie movie) {
  _pushWidgetWithFade(context, MovieDetailScreen(movie));
}

_pushWidgetWithFade(BuildContext context, Widget widget) {
  Navigator.of(context).push(
    PageRouteBuilder(
        transitionsBuilder:
            (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
        pageBuilder: (BuildContext context, Animation animation,
            Animation secondaryAnimation) {
          return widget;
        }),
  );
}