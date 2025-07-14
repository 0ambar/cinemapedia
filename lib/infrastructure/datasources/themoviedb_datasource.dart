import 'package:cinemapedia/config/dio/dio_config.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/themoviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/themoviedb/themoviedb_response.dart';

class ThemoviedbDatasource extends MoviesDatasource {

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {

    final movieDbResponse = TheMovieDbResponse.fromJson(json);
    
    final List<Movie> movies = movieDbResponse.results
    .where((moviedb) => moviedb.posterPath != 'no-poster') // Filter where
    .map(
      (moviedb) => MovieMapper.movieDBtoEntity(moviedb)
    ).toList();
    
    return movies;

  }
  
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    
    final response = await dio.get('/movie/now_playing', 
      queryParameters: {
        'page': page
      }
    );

    return _jsonToMovies(response.data);

  }
  

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {

    final response = await dio.get('/movie/upcoming', 
      queryParameters: {
        'page': page
      }
    );
    
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {

    final response = await dio.get('/movie/popular', 
      queryParameters: {
        'page': page
      }
    );
    
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {

    final response = await dio.get('/movie/top_rated', 
      queryParameters: {
        'page': page
      }
    );
    
    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieById( String movieId ) async {

    final response = await dio.get('/movie/$movieId');
    if(response.statusCode != 200) throw Exception('Movie with id: $movieId not found');

    final movieDB = MovieDetails.fromJson(response.data);
    final Movie movie = MovieMapper.movieDetailsToEntity(movieDB);

    return movie;
  }
  
  @override
  Future<List<Movie>> searchMovies(String query) async {
    
    if( query.isEmpty ) return [];

    final response = await dio.get('/search/movie',
      queryParameters: {
        'query': query
      }
    );

    return _jsonToMovies(response.data);
  }

}