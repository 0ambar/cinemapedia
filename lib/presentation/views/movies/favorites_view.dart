import 'package:flutter/material.dart';

class FavoritesView extends StatelessWidget {

  static String name = 'favorites';
  
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites View'),
      ),
      body: const Center(
        child: Text('Favorites'),
      ),
    );
  }
}