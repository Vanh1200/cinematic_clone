import 'package:cinematic_clone/src/bloc/home_bloc.dart';
import 'package:cinematic_clone/src/utils/api_client.dart';
import 'package:flutter/material.dart';

import 'movie_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController;
  int _page = 0;
  HomeBloc _homeBloc = HomeBloc(ApiClient());

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
      MovieTab(_homeBloc, "popular", key: Key("movies-popular")),
      MovieTab(_homeBloc, "upcoming", key: Key("movies-upcoming")),
      MovieTab(_homeBloc, "top_rated", key: Key("movies-top_rated")),
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
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
