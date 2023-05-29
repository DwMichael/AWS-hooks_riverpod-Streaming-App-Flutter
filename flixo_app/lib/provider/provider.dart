// providers.dart
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../api/tmdb_api.dart';

final tmdbApiProvider = Provider((ref) => TmdbApi());
