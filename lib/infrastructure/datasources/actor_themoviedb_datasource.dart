
import 'package:cinemapedia/config/dio/dio_config.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/themoviedb/credits_response.dart';
import 'package:cinemapedia/infrastructure/models/themoviedb/popular_people_response.dart';

class ActorThemoviedbDatasource extends ActorsDatasource{
  
  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {

    final response = await dio.get('/movie/$movieId/credits');

    final creditsResponse = CreditsResponse.fromJson(response.data);

    final List<Actor> actors = creditsResponse.cast.map(
      (actor) => ActorMapper.castToEntity(actor)
    ).toList();

    return actors;
  }
  
  @override
  Future<List<Actor>> getTrendingPeople({ String timeWindow = 'day' }) async {
    final response = await dio.get('/trending/person/$timeWindow');

    final popularPeopleResponse = PopulaPeopleResponse.fromJson(response.data);

    final List<Actor> people = popularPeopleResponse.people.map(
      (person) => ActorMapper.personToEntity(person)
    ).toList();

    return people;
  }

}