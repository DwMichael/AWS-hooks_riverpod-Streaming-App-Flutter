import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../model/genre.dart';
import '../model/movie.dart';

class TmdbApi {
  final String apiKey = 'b36e3e21d0e7736e57a105307d79ac1f';
  final String readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiMzZlM2UyMWQwZTc3MzZlNTdhMTA1MzA3ZDc5YWMxZiIsInN1YiI6IjY0NmZjMzJlMzM2ZTAxMDEyYWNmMWExMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Oebk-k_Tc1V0j1T5m_eJ5Q2Fv7gKs2jgkB5Hk0vfGFk';

  Future<List<Genre>> getGenres() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readaccesstoken),
      logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true),
      defaultLanguage: 'pl-PL',
    );
    Map genresResult = await tmdbWithCustomLogs.v3.genres.getMovieList();

    return List<Genre>.from(
        genresResult['genres'].map((genre) => Genre.fromJson(genre)));
  }

  Future<List<Movie>> getMovieByGenre(int genreId) async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readaccesstoken),
      logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true),
      defaultLanguage: 'pl-PL',
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
      defaultLanguage: 'pl-PL',
    );
    Map result = await tmdbWithCustomLogs.v3.discover.getMovies();
    return List<Movie>.from(
        result['results'].map((movie) => Movie.fromJson(movie)));
  }

  Future<List<Movie>> getTrendingMovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readaccesstoken),
      logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true),
      defaultLanguage: 'pl-PL',
    );
    Map trendingResult = await tmdbWithCustomLogs.v3.trending.getTrending();

    return List<Movie>.from(
        trendingResult['results'].map((movie) => Movie.fromJson(movie)));
  }

  Future<List<Movie>> getTopRatedMovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readaccesstoken),
      logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true),
      defaultLanguage: 'pl-PL',
    );
    Map topratedResult = await tmdbWithCustomLogs.v3.movies.getTopRated();

    return List<Movie>.from(
        topratedResult['results'].map((movie) => Movie.fromJson(movie)));
  }

  Future<List<Movie>> getTvPopular() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readaccesstoken),
      logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true),
      defaultLanguage: 'pl-PL',
    );
    Map tvResult = await tmdbWithCustomLogs.v3.tv.getPopular();
    return List<Movie>.from(
        tvResult['results'].map((movie) => Movie.fromJson(movie)));
  }
}
