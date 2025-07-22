import 'package:flutter/material.dart';

class PopularPeopleView extends StatelessWidget {

  static String name = 'popular-people';

  const PopularPeopleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular people'),
      ),
      body: const Placeholder(),
    );
  }
}