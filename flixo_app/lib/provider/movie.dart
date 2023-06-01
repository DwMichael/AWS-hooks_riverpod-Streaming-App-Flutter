import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/movie.dart';

final movieListProvider =
    StateNotifierProvider<MovieList, List<Movie>>((ref) => MovieList());

class MovieList extends StateNotifier<List<Movie>> {
  MovieList() : super([]);

  void addMovie(Movie movie) {
    state = [...state, movie];
  }

  void deleteMovie(int index) {
    state = [
      ...state.sublist(0, index),
      ...state.sublist(index + 1),
    ];
  }
}
