import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:flutter/material.dart';

class PeoplePoster extends StatelessWidget {

  final Actor person;
  final double imageHeight;
  final double imageWidth;
  
  const PeoplePoster(
    this.imageHeight,
    this.imageWidth,
    {super.key, required this.person}
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            person.profilePath,
            height: imageHeight,
            width: imageWidth,
            fit: BoxFit.cover,
          ),
        ),
    
        // Actor name
        const SizedBox(height: 5,),
        Text(person.name, maxLines: 2,
          textAlign: TextAlign.center,
        ),
        
        if(person.character != null && person.character!.isNotEmpty)
          Text(person.character!, 
            maxLines: 2,
            style: const TextStyle( fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis,),
            textAlign: TextAlign.center,
          )
      ],
    );
  }
}