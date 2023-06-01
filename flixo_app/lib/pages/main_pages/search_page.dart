import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../../api/tmdb_api.dart';
import '../../model/genre.dart';
import '../../model/movie.dart';
import '../../provider/provider.dart';

class SearchPage extends HookConsumerWidget {
  static const routName = "/searchpage";
  SearchPage({required this.title, super.key});
  final String title;

  final bool isVisible = false;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TmdbApi tmdbApi = ref.watch(tmdbApiProvider);
    final AsyncSnapshot<List<Movie>> randomMovies =
        useFuture(useMemoized(() => tmdbApi.getMovies()));
    if (randomMovies.data == null) {
      return const Align(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );
    }

    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 50,
              child: TextField(
                autocorrect: true,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(top: 5.0, left: 10),
                    child: Column(
                      children: const <Widget>[
                        Icon(Icons.search),
                        Text(
                          "Search",
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  errorStyle: const TextStyle(fontSize: 0.01),
                  fillColor: const Color.fromRGBO(255, 255, 255, 1),
                  filled: true,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const <Widget>[Text("FILTR")],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
    );
  }
}
