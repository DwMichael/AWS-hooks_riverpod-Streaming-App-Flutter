import 'package:tmdb_api/tmdb_api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../model/cast.dart';
import '../model/genre.dart';
import '../model/movie.dart';

class TmdbApi {
  final String apiKey = dotenv.env['API_KEY']!;;
  final String readaccesstoken = dotenv.env['READ_ACCESS_TOKEN']!;

  Future<List<Cast>> getCastList(int movieId) async {
    try {
      TMDB tmdbWithCustomLogs = TMDB(
        ApiKeys(apiKey, readaccesstoken),
        logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true),
        defaultLanguage: 'en-EN',
      );
      Map response = await tmdbWithCustomLogs.v3.movies.getCredits(movieId);

      return List<Cast>.from(
          response['cast'].map((cast) => Cast.fromJson(cast)));
    } catch (error, stacktrace) {
      throw Exception(
          'Exception occurred: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Genre>> getGenres() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readaccesstoken),
      logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true),
      defaultLanguage: 'en-EN',
    );
    Map genresResult = await tmdbWithCustomLogs.v3.genres.getMovieList();

    return List<Genre>.from(
        genresResult['genres'].map((genre) => Genre.fromJson(genre)));
  }

  Future<List<Movie>> getMovieByGenre(int genreId) async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readaccesstoken),
      logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true),
      defaultLanguage: 'en-EN',
    );
    Map result = await tmdbWithCustomLogs.v3.discover.getMovies(
      withGenres: genreId.toString(),
    );

    return List<Movie>.from(
        result['results'].map((movie) => Movie.fromJson(movie)));
  }

  Future<List<Movie>> getMovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readaccesstoken),
      logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true),
      defaultLanguage: 'en-EN',
    );
    Map result = await tmdbWithCustomLogs.v3.discover.getMovies();

    return List<Movie>.from(
        result['results'].map((movie) => Movie.fromJson(movie)));
  }

  Future<List<Movie>> getTrendingMovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readaccesstoken),
      logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true),
      defaultLanguage: 'en-EN',
    );
    Map trendingResult = await tmdbWithCustomLogs.v3.trending.getTrending();

    return List<Movie>.from(
        trendingResult['results'].map((movie) => Movie.fromJson(movie)));
  }

  Future<List<Movie>> getTopRatedMovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readaccesstoken),
      logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true),
      defaultLanguage: 'en-EN',
    );
    Map topratedResult = await tmdbWithCustomLogs.v3.movies.getTopRated();

    return List<Movie>.from(
        topratedResult['results'].map((movie) => Movie.fromJson(movie)));
  }

  Future<List<Movie>> getTvPopular() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readaccesstoken),
      logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true),
      defaultLanguage: 'en-EN',
    );
    Map tvResult = await tmdbWithCustomLogs.v3.tv.getPopular();
    return List<Movie>.from(
        tvResult['results'].map((movie) => Movie.fromJson(movie)));
  }

  Future<List<Movie>> getMovies2() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readaccesstoken),
      logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true),
      defaultLanguage: 'en-EN',
    );
    Map result = await tmdbWithCustomLogs.v3.discover.getMovies();

    return List<Movie>.from(
        result['results'].map((movie) => Movie.fromJson(movie)));
  }
}
