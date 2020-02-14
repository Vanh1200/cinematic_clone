import 'package:cinematic_clone/src/bloc/actor_detail_bloc.dart';
import 'package:cinematic_clone/src/model/cast.dart';
import 'package:cinematic_clone/src/repository/movie_repository.dart';
import 'package:cinematic_clone/src/screen/home/movie_list_item.dart';
import 'package:cinematic_clone/src/utils/fitted_circle_avatar.dart';
import 'package:cinematic_clone/src/utils/styles.dart';
import 'package:flutter/material.dart';

class ActorDetailScreen extends StatelessWidget {
  final Actor _actor;
  ActorDetailBloc _actorDetailBloc;

  ActorDetailScreen(this._actor);

  @override
  Widget build(BuildContext context) {
    _actorDetailBloc = ActorDetailBloc(MovieRepository());
    _actorDetailBloc.getMoviesOfActor(_actor.id.toString());
    _actorDetailBloc.getMoviesOfActor2(_actor.id.toString());

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: primary,
        body: NestedScrollView(
          body: TabBarView(
            children: <Widget>[
              _buildMoviesSection(),
              _buildMoviesSection2(),
            ],
          ),
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) =>
                  [_buildAppBar(context, _actor)],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, Actor actor) {
    return SliverAppBar(
      expandedHeight: 240.0,
      bottom: TabBar(
        tabs: <Widget>[
          Tab(
            icon: Icon(Icons.movie),
          ),
          Tab(
            icon: Icon(Icons.tv),
          ),
        ],
      ),
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            const Color(0xff2b5876),
            const Color(0xff4e4376),
          ])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).padding.top,
              ),
              Hero(
                  tag: 'Cast-Hero-${actor.id}',
                  child: Container(
                    width: 112.0,
                    height: 112.0,
                    child: FittedCircleAvatar(
                      backgroundImage: NetworkImage(actor.profilePictureUrl),
                    ),
                  )),
              Container(
                height: 8.0,
              ),
              Text(
                actor.name,
                style: whiteBody.copyWith(fontSize: 22.0),
              ),
              Container(
                height: 16.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoviesSection() {
    return StreamBuilder(
      stream: _actorDetailBloc.moviesOfActorStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemBuilder: (BuildContext context, int index) =>
                    MovieListItem(snapshot.data[index]),
                itemCount: snapshot.data.length,
              )
            : Padding(
                padding: const EdgeInsets.all(32.0),
                child: Center(child: CircularProgressIndicator()),
              );
      },
    );
  }

  Widget _buildMoviesSection2() {
    return StreamBuilder(
      stream: _actorDetailBloc.moviesOfActorStream2,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemBuilder: (BuildContext context, int index) =>
                    MovieListItem(snapshot.data[index]),
                itemCount: snapshot.data.length,
              )
            : Padding(
                padding: const EdgeInsets.all(32.0),
                child: Center(child: CircularProgressIndicator()),
              );
      },
    );
  }
}
