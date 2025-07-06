
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/themoviedb/movie_themoviedb.dart';

class MovieMapper {

    static Movie movieDBtoEntity( MovieFromMovieDB moviedb ) => Movie(
        adult: moviedb.adult, 
        backdropPath: (moviedb.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500${ moviedb.backdropPath }'
            : 'https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg', 
        genreIds: moviedb.genreIds.map((e) => e.toString()).toList(), 
        id: moviedb.id, 
        originalLanguage: moviedb.originalLanguage, 
        originalTitle: moviedb.originalTitle, 
        overview: moviedb.overview, 
        popularity: moviedb.popularity, 
        posterPath: (moviedb.posterPath != '')
          ? 'https://image.tmdb.org/t/p/w500${ moviedb.posterPath }'
          : 'no-poster', 
        releaseDate: moviedb.releaseDate, 
        title: moviedb.title, 
        video: moviedb.video, 
        voteAverage: moviedb.voteAverage, 
        voteCount: moviedb.voteCount
    );
    
}