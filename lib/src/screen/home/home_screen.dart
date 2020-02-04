import 'package:cinematic_clone/src/bloc/home_bloc.dart';
import 'package:cinematic_clone/src/repository/movie_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'movie_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController;
  int _page = 0;
  HomeBloc _homeBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
          )
        ],
        title: Text("Cinematic"),
      ),
      body: PageView(
        children: _getMovieTab(),
        pageSnapping: true,
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _page = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _getNavBarItems(),
        onTap: _navigationTapped,
        currentIndex: _page,
      ),
    );
  }

  List<BottomNavigationBarItem> _getNavBarItems() {
    return [
      BottomNavigationBarItem(
          icon: Icon(Icons.thumb_up), title: Text('Popular')),
      BottomNavigationBarItem(
          icon: Icon(Icons.update), title: Text('Upcoming')),
      BottomNavigationBarItem(icon: Icon(Icons.star), title: Text('Top Rated')),
    ];
  }

  List<Widget> _getMovieTab() {
    return <Widget>[
      MovieList(_homeBloc, "popular", key: Key("movies-popular")),
      MovieList(_homeBloc, "upcoming", key: Key("movies-upcoming")),
      MovieList(_homeBloc, "top_rated", key: Key("movies-top_rated")),
    ];
  }

  void _navigationTapped(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _homeBloc = Provider.of<HomeBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _homeBloc.dispose();
  }
}
