import 'package:cinematic_clone/src/bloc/home_bloc.dart';
import 'package:flutter/material.dart';

import 'movie_list_item.dart';

class MovieList extends StatefulWidget {
  MovieList(this.homeBloc, this.category, {Key key}) : super(key: key);

  final HomeBloc homeBloc;
  final String category;

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList>
    with AutomaticKeepAliveClientMixin<MovieList> {
  int _pageNumber = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    super.build(context);
    print("init ${widget.category}");
    widget.homeBloc.fetchMovies(widget.category, page: _pageNumber);
  }

  @override
  Widget build(BuildContext context) {
    Stream temp = _getStream();
    temp.listen(_onDataComing);

    super.build(context);
    return Center(
        child: StreamBuilder(
      stream: _getStream(),
      builder: (context, snapshot) => _getContentSection(snapshot),
    ));
  }

  Widget _getContentSection(AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            print("$index : ${snapshot.data.length}");
            if (!_isLoading && index == snapshot.data.length - 1) {
              _isLoading = true;
              widget.homeBloc.fetchMovies(widget.category, page: ++_pageNumber);
            }
            return MovieListItem(snapshot.data[index]);
          });
    } else {
      return CircularProgressIndicator();
    }
  }

  Stream _getStream() {
    switch (widget.category) {
      case "popular":
        return widget.homeBloc.moviesPopularStream;
      case "upcoming":
        return widget.homeBloc.moviesUpcomingStream;
      case "top_rated":
        return widget.homeBloc.moviesTopRatedStream;
      default:
        return widget.homeBloc.moviesPopularStream;
    }
  }

  void _onDataComing(dynamic) {
    _isLoading = false;
  }

  @override
  bool get wantKeepAlive => true;
}
