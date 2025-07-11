
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/infrastructure/datasources/themoviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';

// Inmutable provider
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl( ThemoviedbDatasource() );
});