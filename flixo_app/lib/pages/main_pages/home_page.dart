import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../api/tmdb_api.dart';
import '../../model/movie.dart';
import '../../provider/provider.dart';

class HomePage extends HookConsumerWidget {
  static const routName = "/homepage";
  final String title;

  HomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TmdbApi tmdbApi = ref.watch(tmdbApiProvider);
    final genresList = useFuture(useMemoized(() => tmdbApi.getGenres()));

    return Column(
      children: [
        SizedBox(
          height: 100,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final genre in genresList.data!)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {}, child: Text(genre.name)),
                  ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: genresList.data?.length ?? 0,
            itemBuilder: (BuildContext context, int indexGenres) {
              return CategoryColumn(
                indexGenres: indexGenres,
                categoryName: genresList.data![indexGenres].name,
                categoryIndex: genresList.data![indexGenres].id,
                fetchMovies: () =>
                    tmdbApi.getMovieByGenre(genresList.data![indexGenres].id),
              );
            },
          ),
        ),
      ],
    );
  }
}

class CategoryColumn extends HookConsumerWidget {
  final int indexGenres;
  final String categoryName;
  final int categoryIndex;
  final Future<List<Movie>> Function() fetchMovies;

  const CategoryColumn({
    Key? key,
    required this.indexGenres,
    required this.categoryName,
    required this.categoryIndex,
    required this.fetchMovies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = useFuture(useMemoized(fetchMovies));

    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 15, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$categoryName $categoryIndex"),
          SizedBox(
            height: (indexGenres % 2 == 0) ? 220 : 215,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.data?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: (indexGenres % 2 == 0) ? 170 : 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        fit:
                            (indexGenres % 2 == 0) ? BoxFit.cover : BoxFit.fill,
                        image: CachedNetworkImageProvider(
                          'http://image.tmdb.org/t/p/w500${movies.data![index].posterPath}',
                        ),
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(movies.data![index].title),
                          Text(movies.data![index].rating.toString()),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
