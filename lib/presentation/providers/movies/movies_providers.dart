
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {

  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getNowPlaying;
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
  
});

final popularMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {

  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getPopular;
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
  
});

final upcomingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {

  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getUpcoming;
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
  
});

final topRatedMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {

  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getTopRated;
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
  
});

final trendingMoviesProvider = StateNotifierProvider<TrendingMoviesNotifier, List<Movie>>((ref) {

  final getTrendingMovies = ref.watch( movieRepositoryProvider ).getTrendingMovies;
  return TrendingMoviesNotifier(
    getTrendingMovies: getTrendingMovies
  );
  
});


typedef MovieCallback = Future<List<Movie>> Function({ int page });

class MoviesNotifier extends StateNotifier<List<Movie>> {

  int currentPage = 0;
  bool isLoading = false;
  MovieCallback fetchMoreMovies;

  MoviesNotifier({
    required this.fetchMoreMovies,
  }): super([]);

  Future<void> loadNextPage() async {
    
    if(isLoading) return;

    isLoading = true;
    currentPage++;
    final List<Movie> movies = await fetchMoreMovies( page: currentPage );
    state = [...state, ...movies];
    
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }

}

typedef TrendingMovieCallback = Future<List<Movie>> Function({ String timeWindow });

class TrendingMoviesNotifier extends StateNotifier<List<Movie>> {
  bool isLoading = false;

  TrendingMovieCallback getTrendingMovies;

  TrendingMoviesNotifier({
    required this.getTrendingMovies
  }): super([]);

  Future<void> loadMovies( String timeWindow ) async {
    if( isLoading ) return;

    isLoading = true;
    final movies = await getTrendingMovies(timeWindow: timeWindow);
    state = [...state, ...movies];
    isLoading = false;
  }
}