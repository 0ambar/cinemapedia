
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/themoviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/themoviedb/movie_themoviedb.dart';

class MovieMapper {

  static Movie movieDBtoEntity( MovieFromMovieDB moviedb ) => Movie(
      adult: moviedb.adult, 
      backdropPath: (moviedb.backdropPath != '')
          ? 'https://image.tmdb.org/t/p/w500${ moviedb.backdropPath }'
          : 'https://static.vecteezy.com/system/resources/previews/022/059/000/non_2x/no-image-available-icon-vector.jpg', 
      genreIds: moviedb.genreIds.map((e) => e.toString()).toList(), 
      id: moviedb.id, 
      originalLanguage: moviedb.originalLanguage, 
      originalTitle: moviedb.originalTitle, 
      overview: moviedb.overview, 
      popularity: moviedb.popularity, 
      posterPath: (moviedb.posterPath != '')
        ? 'https://image.tmdb.org/t/p/w500${ moviedb.posterPath }'
        : 'https://moviemarker.co.uk/wp-content/uploads/NoPosterAvailable.jpg', 
      releaseDate: moviedb.releaseDate, 
      title: moviedb.title, 
      video: moviedb.video, 
      voteAverage: moviedb.voteAverage, 
      voteCount: moviedb.voteCount
  );

  static Movie movieDetailsToEntity(MovieDetails moviedb) => Movie(
    adult: moviedb.adult, 
    backdropPath: (moviedb.backdropPath != '')
      ? 'https://image.tmdb.org/t/p/w500${ moviedb.backdropPath }'
      : 'https://static.vecteezy.com/system/resources/previews/022/059/000/non_2x/no-image-available-icon-vector.jpg', 
    genreIds: moviedb.genres.map((e) => e.name).toList(), // Just get the name
    id: moviedb.id, 
    originalLanguage: moviedb.originalLanguage, 
    originalTitle: moviedb.originalTitle, 
    overview: moviedb.overview, 
    popularity: moviedb.popularity, 
    posterPath: (moviedb.posterPath != '')
      ? 'https://image.tmdb.org/t/p/w500${ moviedb.posterPath }'
      : 'https://moviemarker.co.uk/wp-content/uploads/NoPosterAvailable.jpg', 
    releaseDate: moviedb.releaseDate, 
    title: moviedb.title, 
    video: moviedb.video, 
    voteAverage: moviedb.voteAverage, 
    voteCount: moviedb.voteCount
  );
    
}