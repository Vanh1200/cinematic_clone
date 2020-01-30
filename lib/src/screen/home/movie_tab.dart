import 'package:cinematic_clone/src/bloc/home_bloc.dart';
import 'package:cinematic_clone/src/utils/utils.dart';
import 'package:flutter/material.dart';

import 'movie_item.dart';

class MovieTab extends StatefulWidget {
  MovieTab(this.homeBloc, this.category, {Key key}) : super(key: key);

  final HomeBloc homeBloc;
  final String category;

  @override
  _MovieTabState createState() => _MovieTabState();
}

class _MovieTabState extends State<MovieTab> {
  int _pageNumber = 1;
  LoadingState _loadingState = LoadingState.LOADING;
  bool _isLoading = false;

//  _loadNextPage() async {
//    _isLoading = true;
//    try {
//      var nextMovies =
//          await widget.homeBloc.fetchMovies(widget.category, page: _pageNumber);
//      _loadingState = LoadingState.DONE;
//      _movies.addAll(nextMovies);
//      _isLoading = false;
//      _pageNumber++;
//    } catch (e) {
//      _isLoading = false;
//      if (_loadingState == LoadingState.LOADING) {
//        _loadingState = LoadingState.ERROR;
//      }
//    }
//  }

  @override
  void initState() {
    super.initState();
    widget.homeBloc.fetchMovies(widget.category, page: _pageNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: StreamBuilder(
      stream: widget.homeBloc.moviesStream,
      builder: (context, snapshot) => _getContentSection(snapshot),
    ));
  }

  Widget _getContentSection(AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            if (!_isLoading && index > (snapshot.data.length * 0.7)) {
              widget.homeBloc.fetchMovies(widget.category, page: _pageNumber);
            }

            return MovieItem(snapshot.data[index]);
          });
    } else {
      return CircularProgressIndicator();
    }

//      case LoadingState.ERROR:
//        return Text('Sorry, there was an error loading the data!');
//      case LoadingState.LOADING:
//        return CircularProgressIndicator();
//      default:
//        return Container();
//  }
  }
}
