import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../../api/tmdb_api.dart';
import '../../model/genre.dart';
import '../../model/movie.dart';
import '../../provider/category.dart';
import '../../provider/provider.dart';
import '../../widget/star_rating.dart';
import '../side_pages/detail_page.dart';
import 'home_page.dart';

final ValueNotifier<int> selectedButton = useState(0);

class SearchPage extends HookConsumerWidget {
  static const routName = "/searchpage";
  SearchPage({required this.title, super.key});
  final String title;

  final bool isVisible = false;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TmdbApi tmdbApi = ref.watch(tmdbApiProvider);
    final AsyncSnapshot<List<Movie>> randomMovies =
        useFuture(useMemoized(() => tmdbApi.getMovies2()));
    final AsyncSnapshot<List<Genre>> genresList =
        useFuture(useMemoized(() => tmdbApi.getGenres()));

    if (randomMovies.data == null || genresList.data == null) {
      return const Align(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Wrap(
                alignment: WrapAlignment.center,
                verticalDirection: VerticalDirection.down,
                children: [
                  for (final genre in genresList.data!)
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          elevatedButtonTheme: ElevatedButtonThemeData(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  ref.watch(selectedGenreProvider) == genre.id
                                      ? Colors.red
                                      : Colors.white,
                              padding: EdgeInsets.all(10),
                            ),
                          ),
                        ),
                        child: ElevatedButton(
                            onPressed: () {
                              ref.read(selectedGenreProvider.notifier).state =
                                  genre.id;
                            },
                            child: Text(
                              textAlign: TextAlign.center,
                              genre.name,
                              style: TextStyle(
                                fontSize: 10,
                                color:
                                    ref.watch(selectedGenreProvider) == genre.id
                                        ? Colors.white
                                        : Colors.black,
                              ),
                            )),
                      ),
                    ),
                ],
              ),
            ),
            ref.read(selectedGenreProvider.notifier).state != 0
                ? const CategoryColumnSearch()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0.0, vertical: 10),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 10,
                        mainAxisExtent: 300,
                      ),
                      shrinkWrap: true,
                      itemCount: 6,
                      itemBuilder: (BuildContext context, int index) {
                        return CachedNetworkImage(
                          filterQuality: FilterQuality.low,
                          fit: BoxFit.cover,
                          imageUrl:
                              'http://image.tmdb.org/t/p/w500${randomMovies.data![index].posterPath}',
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class CategoryColumnSearch extends HookConsumerWidget {
  const CategoryColumnSearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = ref.watch(selectedGenreProvider);

    final TmdbApi tmdbApi = ref.watch(tmdbApiProvider);

    final fetchMovies = useState<List<Movie>?>(null);

    useEffect(() {
      fetchMovies.value = null;
      Future.microtask(
          () async => fetchMovies.value = await tmdbApi.getMovieByGenre(id));
      return null;
    }, [id]);

    if (fetchMovies.value == null) {
      return const SizedBox(
        height: 250,
        child: Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: fetchMovies.value!.length,
          itemBuilder: (
            BuildContext context,
            int index,
          ) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        DetailPage(movie: fetchMovies.value![index]))),
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SizedBox(
                          height: 400,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Hero(
                            tag: fetchMovies.value![index],
                            child: CachedNetworkImage(
                              filterQuality: FilterQuality.medium,
                              fit: BoxFit.fitWidth,
                              imageUrl:
                                  'http://image.tmdb.org/t/p/w500${fetchMovies.value![index].posterPath}',
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 22,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                  Colors.black,
                                  Colors.transparent
                                ])),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, bottom: 5),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: StarRating(
                                sizeIcon: 17,
                                rating: fetchMovies.value![index].rating),
                          ),
                        )
                      ],
                    ),
                  ).animate().fadeIn(curve: Curves.easeInOut).slideX(),
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
