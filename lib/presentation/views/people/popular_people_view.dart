import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PopularPeopleView extends ConsumerStatefulWidget {

  static String name = 'popular-people';
  final String timeWindow;

  const PopularPeopleView({required this.timeWindow, super.key});

  @override
  PopularPeopleViewState createState() => PopularPeopleViewState();
}

class PopularPeopleViewState extends ConsumerState<PopularPeopleView> {

  @override
  void initState() {
    super.initState();
    ref.read( popularPeopleProvider.notifier )
      .loadPeople( widget.timeWindow );
  }

  @override
  Widget build(BuildContext context) {

    final List<Actor> popularPeople = ref.watch( popularPeopleProvider );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular people'),
      ),
      body: ListView.builder(
        itemCount: popularPeople.length,
        itemBuilder: (context, index) {
          final person = popularPeople[index];
          print(popularPeople.length);
          print(person);
          return Text(popularPeople[index].name);
        }
      ),
    );
  }
}