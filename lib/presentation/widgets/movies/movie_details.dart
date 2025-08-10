import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';

import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

class MovieDetails extends StatelessWidget {

  final Movie movie; 

  const MovieDetails({
    required this.movie,
    super.key
  });

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;

    return Column(
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
                
                return GestureDetector(
                  onTap: () => context.push('/home/0/movie/${ movie.id }'),
                  child: FadeIn(child: child),
                );

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
              Text(HumanFormats.number(movie.voteAverage, 1), style: textStyles.bodyMedium?.copyWith(color: Colors.yellow.shade800), ),
              const Spacer(),
              Text(HumanFormats.number(movie.popularity), style: textStyles.bodySmall,)
            ],
          ),
        )
      ],
    );
  }
}