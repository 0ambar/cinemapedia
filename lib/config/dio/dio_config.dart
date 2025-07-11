import 'package:cinemapedia/config/constants/environment.dart';
import 'package:dio/dio.dart';

final dio = Dio(BaseOptions(
  baseUrl: 'https://api.themoviedb.org/3',
  queryParameters: {
    'api_key': Environment.theMovieDbKey,
    'language': 'en-US'
  },
));