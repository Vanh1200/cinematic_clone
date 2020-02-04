import 'package:cinematic_clone/src/utils/utils.dart';

class Actor {
  String character;
  String name;
  String profilePicture;
  int id;

  get profilePictureUrl =>
      getMediumPictureUrl((profilePicture != null ? profilePicture : ""));

  Actor.fromMap(Map jsonMap)
      : character = jsonMap['character'],
        name = jsonMap['name'],
        profilePicture = jsonMap['profile_path'],
        id = jsonMap['id'];
}
