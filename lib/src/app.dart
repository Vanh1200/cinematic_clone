import 'package:cinematic_clone/src/screen/home/home_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cinematic clone',
      theme: ThemeData.dark(),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}