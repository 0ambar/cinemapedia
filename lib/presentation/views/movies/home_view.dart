import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';


class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}


// Consumer has scope to 'state'
class HomeViewState extends ConsumerState<HomeView> {

  @override
  void initState() {
    super.initState();

    ref.read( nowPlayingMoviesProvider.notifier ).loadNextPage();
    ref.read( popularMoviesProvider.notifier ).loadNextPage();
    ref.read( upcomingMoviesProvider.notifier ).loadNextPage();
    ref.read( topRatedMoviesProvider.notifier ).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final isLoading = ref.watch( initialLoadingProvider );
    if(isLoading) return const FullScreenLoader();
    
    final nowPlayingMovies = ref.watch( nowPlayingMoviesProvider );
    final popularMovies = ref.watch( popularMoviesProvider );
    final upcomingMovies = ref.watch( upcomingMoviesProvider );
    final topRatedMovies = ref.watch( topRatedMoviesProvider );

    final slideShowMovies = ref.watch( moviesSlideshowProvider );

   
    return CustomScrollView(
      slivers: [
    
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: CustomAppbar(),
          ),
        ),
    
        SliverList(delegate: SliverChildBuilderDelegate(
          
          childCount: 1,          
          (context, index) {
    
            return Column(
              children: [
            
                MoviesSlideshow(movies: slideShowMovies),
            
                MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'Playing',
                  subtitle: 'Today',
                  loadNextpage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
                ),
            
                MovieHorizontalListview(
                  movies: upcomingMovies,
                  title: 'Soon',
                  subtitle: 'This month',
                  loadNextpage: () => ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
                ),
            
                MovieHorizontalListview(
                  movies: popularMovies,
                  title: 'Popular',
                  subtitle: '',
                  loadNextpage: () => ref.read(popularMoviesProvider.notifier).loadNextPage(),
                ),
            
                MovieHorizontalListview(
                  movies: topRatedMovies,
                  title: 'The bests',
                  subtitle: 'Everytime',
                  loadNextpage: () => ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
                ),
    
                const SizedBox(height: 15,)
              ]
            );
          
          },
          
        ))
      ],
    );
  }
}