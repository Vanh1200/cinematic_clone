import 'dart:async';
import 'dart:math';

import 'package:cinematic_clone/src/bloc/movie_detail_bloc.dart';
import 'package:cinematic_clone/src/customview/bottom_gradient.dart';
import 'package:cinematic_clone/src/customview/text_bubble.dart';
import 'package:cinematic_clone/src/model/cast.dart';
import 'package:cinematic_clone/src/model/movie.dart';
import 'package:cinematic_clone/src/repository/movie_repository.dart';
import 'package:cinematic_clone/src/screen/detail/similar_section.dart';
import 'package:cinematic_clone/src/utils/styles.dart';
import 'package:cinematic_clone/src/utils/utils.dart';
import 'package:flutter/material.dart';

import 'cast_section.dart';
import 'meta_section.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;

  MovieDetailScreen(this.movie);

  @override
  MovieDetailScreenState createState() {
    return MovieDetailScreenState();
  }
}

class MovieDetailScreenState extends State<MovieDetailScreen> {
  MovieDetailBloc _movieDetailBloc = MovieDetailBloc(MovieRepository());
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _movieDetailBloc.getMovieDetail(widget.movie.id.toString());
    _movieDetailBloc.getMovieCasts(widget.movie.id.toString());
    _movieDetailBloc.getSimilarMovies(widget.movie.id.toString());

    Timer(Duration(milliseconds: 100), () => setState(() => _visible = true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primary,
        body: CustomScrollView(
          slivers: <Widget>[
            _buildAppBar(widget.movie),
            _buildContentSection(widget.movie),
          ],
        ));
  }

  Widget _buildAppBar(Movie movie) {
    return SliverAppBar(
      expandedHeight: 240.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Hero(
              tag: "Movie-Tag-${widget.movie.id}",
              child: FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: "assets/placeholder.jpg",
                  image: widget.movie.getBackDropUrl()),
            ),
            BottomGradient(),
            _buildMetaSection(movie)
          ],
        ),
      ),
    );
  }

  Widget _buildMetaSection(Movie movie) {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                TextBubble(
                  movie.getReleaseYear().toString(),
                  backgroundColor: Color(0xffF47663),
                ),
                Container(
                  width: 8.0,
                ),
                TextBubble(movie.voteAverage.toString(),
                    backgroundColor: Color(0xffF47663)),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(movie.title,
                  style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 20.0)),
            ),
            Row(
              children: getGenresForIds(movie.genreIds)
                  .sublist(0, min(5, movie.genreIds.length))
                  .map((genre) => Row(
                        children: <Widget>[
                          TextBubble(genre),
                          Container(
                            width: 8.0,
                          )
                        ],
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildContentSection(Movie media) {
    return SliverList(
      delegate: SliverChildListDelegate(<Widget>[
        Container(
          decoration: BoxDecoration(color: const Color(0xff222128)),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "SYNOPSIS",
                  style: const TextStyle(color: Colors.white),
                ),
                Container(
                  height: 8.0,
                ),
                Text(media.overview,
                    style:
                        const TextStyle(color: Colors.white, fontSize: 12.0)),
                Container(
                  height: 8.0,
                ),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(color: primary),
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: StreamBuilder(
                stream: _movieDetailBloc.movieCreditsStream,
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : CastSection(snapshot.data);
                }
              )),
        ),
        Container(
          decoration: BoxDecoration(color: primaryDark),
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: StreamBuilder(
                stream: _movieDetailBloc.movieDetailStream,
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : MetaSection(snapshot.data);
                }
              )),
        ),
        Container(
            decoration: BoxDecoration(
              color: primary,
            ),
            child: StreamBuilder(
              stream: _movieDetailBloc.similarMoviesStream,
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? Container()
                    : SimilarSection(snapshot.data);
              }
            ))
      ]),
    );
  }
}
