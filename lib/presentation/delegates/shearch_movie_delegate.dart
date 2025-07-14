
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function( String query );

class ShearchMovieDelegate extends SearchDelegate<Movie?> {

  final SearchMoviesCallback searchMovies;
  List<Movie> initialMovies;
  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast(); // Multiple listeners
  StreamController<bool> isLoadingStream = StreamController.broadcast(); // Multiple listeners
  Timer? _debounceTimer;

  ShearchMovieDelegate({
    required this.searchMovies,
    required this.initialMovies
  });

  void clearStreams() {
    debouncedMovies.close();
    isLoadingStream.close();
  }

  void _onQueryChanged ( String query ) {    

    isLoadingStream.add(true);

    // Stop timer
    if( _debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer( const Duration( milliseconds: 300 ), () async {
      final movies = await searchMovies(query);
      if( !debouncedMovies.isClosed ) {
        debouncedMovies.add(movies);
        initialMovies = movies;
        isLoadingStream.add(false);
      }
    });
  }

  Widget buildResultsAndSuggestions() {
    return StreamBuilder(
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {

        final movies = snapshot.data ?? []; // Empty arrary from initial stream
        
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MovieItem(
            movie: movies[index],
            onMovieSelected: (context, movie) {
              clearStreams();
              close(context, movie);
            }
          )
        );
      },
    );
  }

  // Sarch field placeholder
  @override
  String? get searchFieldLabel => 'Search movie';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [

      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream, 
        builder: (context, snapshot) {

          if( snapshot.data ?? false ) {
            return const Padding(
              padding: EdgeInsets.only(right: 15),
              child: SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            );
          }

          return FadeIn(
            animate: query.isNotEmpty,
            duration: const Duration(milliseconds: 90),
            child: IconButton(
              // 'query' comes from SearchDelegate. Is the entered text on the shearch field
              onPressed: () => query = '', 
              icon: const Icon(Icons.clear)
            ),
          );
          
        }
      )
      
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      // 'close()' comes from SarchDelegate
      // Params: context: context, result: return value when close
      onPressed: () {
        clearStreams();
        close(context, null);
      }, 
      icon: const Icon(Icons.arrow_back_ios_new_rounded)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return buildResultsAndSuggestions();
  }
}

class _MovieItem extends ConsumerWidget {

  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({
    required this.movie, 
    required this.onMovieSelected
  });

  @override
  Widget build(BuildContext context, ref) {

    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        // Update providers state
        ref.read( searchQueryProvider.notifier ).update((state) => '');
        ref.read( searchedMoviesProvider.notifier ).clearState();
        onMovieSelected(context, movie);
      },

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
          
            // Movie image
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) => FadeIn(child: child),
                ),
              ),
            ),
      
            const SizedBox(width: 10),
      
            // Movie description
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
      
                  Text( movie.title, style: textStyles.titleMedium,),
      
                  ( movie.overview.length > 100 )
                    ? Text( '${movie.overview.substring(0, 100)}...' )
                    : Text( movie.overview ),
      
                  Row(
                    children: [
                      Icon(Icons.star_half_rounded, color: Colors.yellow.shade800,),
                      const SizedBox(width: 5,),
                      Text(
                        HumanFormats.number( movie.voteAverage, 1 ),
                        style: textStyles.bodyMedium!.copyWith(color: Colors.yellow.shade800),
                      ),
                    ],
                  ),
                ],
              ),
            ),
      
          ],
        ),
      ),
    );
  }
}