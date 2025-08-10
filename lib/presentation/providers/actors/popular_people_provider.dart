import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

final trendingPeopleProviderByDay = StateNotifierProvider<PopularPeopleNotifier, List<Actor>>((ref) {
  final actorsRepository = ref.watch( actorsRepositoryProvider );
  return PopularPeopleNotifier( getTrendingPeople: actorsRepository.getTrendingPeople );
});

typedef GetPopularPeopleCallback = Future<List<Actor>> Function({ String timeWindow });

class PopularPeopleNotifier extends StateNotifier<List<Actor>> {

  bool isLoading = false;

  GetPopularPeopleCallback getTrendingPeople;

  PopularPeopleNotifier({
    required this.getTrendingPeople
  }): super([]);

  Future<void> loadPeople( String timeWindow ) async {
    if( isLoading ) return;

    isLoading = true;
    final people = await getTrendingPeople(timeWindow: timeWindow);
    state = [...state, ...people];
    isLoading = false;
  }

}