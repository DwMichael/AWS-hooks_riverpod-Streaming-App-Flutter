import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flixo_app/pages/main_pages/download_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../api/tmdb_api.dart';
import '../../model/cast.dart';
import '../../model/movie.dart';
import '../../provider/movie.dart';
import '../../provider/provider.dart';
import '../../provider/video_provider.dart';
import '../../widget/star_rating.dart';
import 'package:http/http.dart' as http;

class DetailPage extends HookConsumerWidget {
  const DetailPage({required this.movie, Key? key}) : super(key: key);
  final Movie movie;
  final String videoUrl = 'https://example.com/video.mp4';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controller = useState<VideoPlayerController?>(null);
    final _isPlaying = useState(false);
    final _isImageLoaded = useState(false);
    final TmdbApi tmdbApi = ref.watch(tmdbApiProvider);
    final castList =
        useFuture(useMemoized(() => tmdbApi.getCastList(movie.id)));
    void _playVideo() {
      _controller.value = VideoPlayerController.network(
          'https://d1g8hloj55af01.cloudfront.net/vods/kings_of_la_trailer_1_h1080p/mp4/kings_of_la_trailer_1_h1080p.mp4')
        ..addListener(
            () => _isPlaying.value = _controller.value!.value.isPlaying)
        ..setLooping(true)
        ..initialize().then((value) => _controller.value!.play());
    }

    // Dispose of the controller when the widget is removed from the tree
    useEffect(() {
      return () => _controller.value?.dispose();
    }, []);
    if (castList.hasData) {
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2D2D2D), Color(0xFF4A4A4A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_rounded),
              color: Colors.white,
            ),
          ),
          body: Hero(
            tag: movie,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 340,
                    child: GestureDetector(
                      onTap: () async {
                        // Use the future result within the callback
                        if (_controller.value == null) {
                          _playVideo();
                        } else if (_isPlaying.value) {
                          _controller.value!.pause();
                        } else {
                          _controller.value!.play();
                        }
                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                            child: _controller.value != null
                                ? VideoPlayer(_controller.value!)
                                : CachedNetworkImage(
                                    imageUrl:
                                        'https://image.tmdb.org/t/p/original/${movie.posterPath}',
                                    imageBuilder: (context, imageProvider) {
                                      WidgetsBinding.instance!
                                          .addPostFrameCallback((_) {
                                        _isImageLoaded.value = true;
                                      });
                                      return Image(
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          image: imageProvider);
                                    },
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                          ),
                          if (_isImageLoaded.value)
                            Positioned.fill(
                              child: Center(
                                child: AnimatedOpacity(
                                  opacity:
                                      !_isPlaying.value && _isImageLoaded.value
                                          ? 1.0
                                          : 0.0,
                                  duration: const Duration(milliseconds: 300),
                                  child: AnimatedOpacity(
                                    opacity: !_isPlaying.value &&
                                            _isImageLoaded.value
                                        ? 1.0
                                        : 0.0,
                                    duration: const Duration(milliseconds: 300),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(top: 180.0),
                                      child: Column(
                                        children: [
                                          const Icon(
                                            Icons.play_circle_outline,
                                            color: Colors.yellow,
                                            size: 65,
                                          ),
                                          Text(
                                            movie.title.toUpperCase(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'muli',
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StarRating(sizeIcon: 40, rating: movie.rating),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.amber,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.file_download_outlined,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    ref
                                        .read(movieListProvider.notifier)
                                        .addMovie(movie);
                                  },
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                  const Center(
                    child: Text(
                      "Opis",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 18),
                    child: Center(
                      child: Text(
                        movie.overview,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 18),
                    child: SizedBox(
                      height: 200.0,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: castList.data!.length,
                        separatorBuilder: (context, index) =>
                            const VerticalDivider(
                          color: Colors.transparent,
                          width: 10,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: <Widget>[
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                elevation: 3,
                                child: ClipRRect(
                                  child: CachedNetworkImage(
                                    filterQuality: FilterQuality.low,
                                    imageUrl:
                                        'https://image.tmdb.org/t/p/w200${castList.data![index].profilePath}',
                                    imageBuilder: (context, imageBuilder) {
                                      return Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(100)),
                                          image: DecorationImage(
                                            image: imageBuilder,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                    placeholder: (context, url) => Container(
                                      width: 80,
                                      height: 80,
                                      child: Center(
                                        child: Platform.isAndroid
                                            ? const CircularProgressIndicator()
                                            : const CupertinoActivityIndicator(),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      width: 80,
                                      height: 80,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/image/user.png'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  castList.data![index].name.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 8,
                                    fontFamily: 'muli',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: SizedBox(
                                  width: 100,
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    castList.data![index].character
                                        .toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white54,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 8,
                                      fontFamily: 'muli',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return const Center(
        child: SizedBox(
            height: 100, width: 100, child: CircularProgressIndicator()),
      );
    }
  }
}
