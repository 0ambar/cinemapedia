import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieHorizontalListview extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextpage;

  const MovieHorizontalListview({
    super.key, 
    required this.movies, 
    this.title, 
    this.subtitle, 
    this.loadNextpage
  });

  @override
  State<MovieHorizontalListview> createState() => _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {

  final scrollControler = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollControler.addListener(() {
      if(widget.loadNextpage == null) return;

      if((scrollControler.position.pixels + 200) >= scrollControler.position.maxScrollExtent) {
        widget.loadNextpage!();
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
    return SizedBox(
      height: 350,
      child: Column(
        children: [

          if(widget.title != null || widget.subtitle != null)
            _Title(title: widget.title, subtitle: widget.subtitle,),

          Expanded(
            child: ListView.builder(
              controller: scrollControler,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (context, index) {
                return FadeInRight( child: _Slide(movie: widget.movies[index],));
              }
            )
          )
            
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {

  final String? title;
  final String? subtitle;

  const _Title({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {

    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if(title != null) Text(title!, style: titleStyle),

          const Spacer(),

          if(subtitle != null) 
            FilledButton.tonal(style: const ButtonStyle(visualDensity: VisualDensity.compact), onPressed: (){}, child: Text(subtitle!),)
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {

  final Movie movie;
  
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          
          // * Poster image
          SizedBox(
            width: 150,
            height: 230,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                width: 150,
                height: 230,
                loadingBuilder: (context, child, loadingProgress) {
                  if(loadingProgress != null) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator(strokeWidth: 2.0,),),
                    );
                  }

                  return FadeIn(child: child);
                },
              ),
            ),
          ),

          // * Fixed spacer
          const SizedBox(height: 5,),

          // * Title 
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,textAlign: TextAlign.center,
              style: textStyles.titleSmall,
            ),
          ),

          // * Rating
          SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon(Icons.star_half_outlined, color: Colors.yellow.shade800,),
                const SizedBox(width: 3,),
                Text('${movie.voteAverage}', style: textStyles.bodyMedium?.copyWith(color: Colors.yellow.shade800), ),
                const Spacer(),
                Text(HumanFormats.number(movie.popularity), style: textStyles.bodySmall,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
