import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tmdb_api/tmdb_api.dart';
import '../../api/tmdb_api.dart';
import '../../model/genre.dart';
import '../../model/movie.dart';
import '../../provider/provider.dart';
import '../../widget/star_rating.dart';

class HomePage extends HookConsumerWidget {
  static const routName = "/homepage";
  final String title;

  HomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TmdbApi tmdbApi = ref.watch(tmdbApiProvider);
    final AsyncSnapshot<List<Genre>> genresList =
        useFuture(useMemoized(() => tmdbApi.getGenres()));
    if (genresList.data == null) {
      return const Align(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );
    }
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: genresList.data?.length ?? 0,
            itemBuilder: (BuildContext context, int indexGenres) {
              return MainMoviesRow(
                fetchMovies: () =>
                    tmdbApi.getMovieByGenre(genresList.data![indexGenres].id),
              );
            },
          ),
        ),
        SizedBox(
          height: 150,
          child: SingleChildScrollView(
            child: Wrap(
              verticalDirection: VerticalDirection.down,
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

class MainMoviesRow extends HookConsumerWidget {
  const MainMoviesRow({required this.fetchMovies, super.key});
  final Future<List<Movie>> Function() fetchMovies;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = useFuture(useMemoized(fetchMovies));
    final _current = useState(0);
    if (movies.data == null) {
      return const Align(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 10, top: 15, bottom: 15),
        child: SizedBox(
          height: 250,
          child: CarouselSlider(
            items: movies.data!
                .map((item) => Container(
                      child: Center(
                          child: Image.network(item.posterPath.toString(),
                              fit: BoxFit.cover, width: 1000)),
                    ))
                .toList(),
            options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 8),
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  _current.value = index;
                }),
          ),

          //  ListView.builder(
          //   scrollDirection: Axis.horizontal,
          //   itemCount: movies.data?.length ?? 0,
          //   itemBuilder: (BuildContext context, int index) {
          //     return Padding(
          //       padding: const EdgeInsets.all(10.0),
          //       child: Center(
          //         child: Container(
          //           width: 300,
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(20),
          //           ),
          //           clipBehavior: Clip.antiAlias,
          //           child:
          //            Stack(
          //             clipBehavior: Clip.none,
          //             children: [
          //               SizedBox(
          //                 width: double.infinity,
          //                 child: CachedNetworkImage(
          //                   fit: BoxFit.fitWidth,
          //                   imageUrl:
          //                       'http://image.tmdb.org/t/p/w500${movies.data![index].posterPath}',
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ),
      );
    }
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
          Align(
            alignment: const Alignment(0.0, 1.0),
            child: Text(
              categoryName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.data?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: 190,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: CachedNetworkImage(
                            fit: BoxFit.fitWidth,
                            imageUrl:
                                'http://image.tmdb.org/t/p/w500${movies.data![index].posterPath}',
                          ),
                        ),
                        Container(
                          height: 30,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Colors.black, Colors.transparent]),
                          ),
                        ),
                        Positioned(
                          left: 10,
                          top: 2,
                          child: StarRating(
                            rating: movies.data![index].rating,
                          ),
                        )
                      ],
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
