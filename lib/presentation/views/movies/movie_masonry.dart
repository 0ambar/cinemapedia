import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MovieMasonry extends StatefulWidget {
  
  final List<Movie> movies;
  final VoidCallback? loadNextPage;

  const MovieMasonry({
    super.key, 
    required this.movies, 
    this.loadNextPage
  });

  @override
  State<MovieMasonry> createState() => _MovieMasonryState();
}

class _MovieMasonryState extends State<MovieMasonry> {

  final scrollControler = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollControler.addListener(() {
      if( widget.loadNextPage == null ) return;

      if( (scrollControler.position.pixels + 50) >= scrollControler.position.maxScrollExtent ) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MasonryGridView.count(
        crossAxisCount: 3, // 3 columns
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: widget.movies.length,
        controller: scrollControler,
        itemBuilder: (context, index) {
          if(index == 1) {
            return Column(
              children: [
                const SizedBox(height: 20,),
                MoviePosterLink(movie: widget.movies[index])
              ],
            );
          }
          return MoviePosterLink( movie: widget.movies[index]);
        },
      ),
    );
  }
}
