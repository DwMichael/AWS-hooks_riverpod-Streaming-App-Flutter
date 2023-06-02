import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedGenreProvider =
    StateNotifierProvider<CategoryId, int>((ref) => CategoryId());

class CategoryId extends StateNotifier<int> {
  CategoryId() : super(0);

  void setGenreProvider(int id) {
    state = id;
  }
}
