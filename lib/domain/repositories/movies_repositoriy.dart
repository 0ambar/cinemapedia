import 'package:cinemapedia/domain/entities/movie.dart';

abstract class MoviesRepositoriy {

  Future<List<Movie>> getNowPlaying({ int page = 1 });

}