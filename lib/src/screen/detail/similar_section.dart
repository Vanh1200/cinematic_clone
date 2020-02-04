import 'package:cinematic_clone/src/model/movie.dart';
import 'package:cinematic_clone/src/utils/navigator.dart';
import 'package:flutter/material.dart';

class SimilarSection extends StatelessWidget {
  final List<Movie> _similarMovies;

  SimilarSection(this._similarMovies);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Similar",
            style: TextStyle(color: Colors.white),
          ),
        ),
        Container(
          height: 300.0,
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            scrollDirection: Axis.horizontal,
            children: _similarMovies
                .map((Movie movie) => GestureDetector(
                      onTap: () => goToMovieDetails(context, movie),
                      child: FadeInImage.assetNetwork(
                        image: movie.getPosterUrl(),
                        placeholder: 'assets/placeholder.jpg',
                        height: 150.0,
                        fit: BoxFit.cover,
                      ),
                    ))
                .toList(),
          ),
        )
      ],
    );
  }
}
