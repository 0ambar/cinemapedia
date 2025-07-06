
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/infrastructure/datasources/themoviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';

// Inmutable repository
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl( ThemoviedbDatasource() );
});