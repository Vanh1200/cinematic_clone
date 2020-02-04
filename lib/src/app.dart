import 'package:cinematic_clone/src/bloc/home_bloc.dart';
import 'package:cinematic_clone/src/repository/movie_repository.dart';
import 'package:cinematic_clone/src/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cinematic clone',
      theme: ThemeData.dark(),
      home: Provider (
        create: (_) => HomeBloc(MovieRepository()),
        child: HomeScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}