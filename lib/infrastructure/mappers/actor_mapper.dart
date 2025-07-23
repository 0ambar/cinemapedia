
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/themoviedb/credits_response.dart';
import 'package:cinemapedia/infrastructure/models/themoviedb/popular_people_response.dart';

class ActorMapper {

  static Actor castToEntity( Cast cast ) => Actor(
    id: cast.id, 
    name: cast.name,
    profilePath: ( cast.profilePath != null)
      ? 'https://image.tmdb.org/t/p/w500${ cast.profilePath }'
      : 'https://i.pinimg.com/736x/9e/83/75/9e837528f01cf3f42119c5aeeed1b336.jpg',
    character: cast.character
  );

  static Actor personToEntity( Person person ) => Actor(
    id: person.id, 
    name: person.name, 
    profilePath: ( person.profilePath != null)
      ? 'https://image.tmdb.org/t/p/w500${ person.profilePath }'
      : 'https://i.pinimg.com/736x/9e/83/75/9e837528f01cf3f42119c5aeeed1b336.jpg',
    character: null
  );
}