import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoritesView extends ConsumerStatefulWidget {

  static String name = 'favorites';
  
  const FavoritesView({super.key});
  
  @override
  ConsumerState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> with AutomaticKeepAliveClientMixin {

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
    super.build(context);

    final colors = Theme.of(context).colorScheme;
    final favoriteMovies = ref.watch( favoriteMoviesProvider ).values.toList();

    if( favoriteMovies.isEmpty ) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Icon(Icons.favorite_outline_sharp, size: 60, color: colors.primary,),
            Text('Ohh no!', style: TextStyle(fontSize: 30, color: colors.primary),),
            const Text("You don´t have favorites", style: TextStyle(fontSize: 20, color: Colors.black45),),

            const SizedBox(height: 20,), 
            FilledButton(
              onPressed: () => context.go('/home/0'), 
              child: const Text('Start searching'),
            ),
          ],
        ),
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: MovieMasonry(
        movies: favoriteMovies,
        loadNextPage: loadNextPage,
      )
    );
  }
  
  @override
  bool get wantKeepAlive => true;

}