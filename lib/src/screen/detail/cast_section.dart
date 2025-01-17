import 'package:cinematic_clone/src/model/cast.dart';
import 'package:flutter/material.dart';

import 'cast_card.dart';

class CastSection extends StatelessWidget {
  final List<Actor> _cast;

  CastSection(this._cast);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Cast",
          style: TextStyle(color: Colors.white),
        ),
        Container(
          height: 8.0,
        ),
        Container(
          height: 140.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: _cast
                .map((Actor actor) => Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CastCard(actor),
                    ))
                .toList(),
          ),
        )
      ],
    );
  }
}
