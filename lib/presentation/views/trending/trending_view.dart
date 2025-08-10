import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';

import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

class TrendingView extends ConsumerStatefulWidget {

  static String name = 'popular-people';

  const TrendingView({ super.key});

  @override
  PopularPeopleViewState createState() => PopularPeopleViewState();
}

class PopularPeopleViewState extends ConsumerState<TrendingView> {

  @override
  void initState() {
    super.initState();
    ref.read( trendingPeopleProviderByDay.notifier )
      .loadPeople('day');
    ref.read( trendingMoviesProvider.notifier )
      .loadMovies('day');
  }

  @override
  Widget build(BuildContext context) {

    final List<Actor> trendingPeopleByDay = ref.watch( trendingPeopleProviderByDay );
    final List<Movie> trendingMoviesByDay = ref.watch( trendingMoviesProvider );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Today's trending"),
        ),
      
        body: Column(
          children: [
            // const 
            const TabBar(
              tabs: [
                _CustomTab(
                  icon: Icon(Icons.movie_filter_outlined), 
                  text: 'Movies',
                ),

                _CustomTab(
                  icon: Icon(Icons.people_outline_outlined), 
                  text: 'People',
                )
              ]
            ),
        
            Expanded(
              child: TabBarView(
                children: [
                  _TrendingMoviesGrid(movies: trendingMoviesByDay),
                  
                  _TrendingPeopleGrid(popularPeople: trendingPeopleByDay),
              
                ]
              ),
            )
          ],
        )
      
      ),
    );
  }
}

class _CustomTab extends StatelessWidget {
  
  final Icon icon;
  final String text;
  
  const _CustomTab({
    required this.icon, 
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: [
          icon,
          Text(text),
        ]
      ),
    );
  }
}

class _TrendingMoviesGrid extends StatelessWidget {
  
  final List<Movie> movies;

  const _TrendingMoviesGrid({required this.movies});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: movies.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 320,
      ),

      itemBuilder: (context, index) {
        final movie = movies[index];

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: MovieDetails(movie: movie),
        );
      },
      
    );
  }
}

class _TrendingPeopleGrid extends StatelessWidget {

  final List<Actor> popularPeople;

  const _TrendingPeopleGrid({
    required this.popularPeople,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: popularPeople.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, 
        mainAxisExtent: 295
      ),
      itemBuilder: (context, index) {

        final person = popularPeople[index];

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: FadeIn(child: PeoplePoster(230, 150, person: person))
        );
      },
      
    );
  }
}