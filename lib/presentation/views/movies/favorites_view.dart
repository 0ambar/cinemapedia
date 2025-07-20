import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesView extends ConsumerStatefulWidget {

  static String name = 'favorites';
  
  const FavoritesView({super.key});
  
  @override
  ConsumerState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {

  bool isLoading = false;
  bool isLastPage = false;

  void loadNextPage() async {
    if( isLoading || isLastPage ) return;

    isLoading = true;
    final movies = await ref.read( favoriteMoviesProvider.notifier ).loadNextPage();
    isLoading = false;

    if( movies.isEmpty ) isLastPage = true;
  }

  @override
  void initState() {
    super.initState();
    ref.read( favoriteMoviesProvider.notifier ).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final favoriteMovies = ref.watch( favoriteMoviesProvider ).values.toList();
    
    return Scaffold(
      body: MovieMasonry(
        movies: favoriteMovies,
        loadNextPage: loadNextPage,
      )
    );
  }

}