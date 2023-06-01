import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../../api/tmdb_api.dart';
import '../../model/cast.dart';
import '../../model/movie.dart';
import '../../provider/provider.dart';
import '../../widget/star_rating.dart';

class DetailPage extends HookConsumerWidget {
  const DetailPage({required this.movie, Key? key}) : super(key: key);
  final Movie movie;

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

    return Scaffold(
      body: Hero(
        tag: movie,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                ),
              ),
              expandedHeight: 340,
              floating: true,
              pinned: true,
              snap: true,
              flexibleSpace: GestureDetector(
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
                            opacity: !_isPlaying.value && _isImageLoaded.value
                                ? 1.0
                                : 0.0,
                            duration: const Duration(milliseconds: 300),
                            child: AnimatedOpacity(
                              opacity: !_isPlaying.value && _isImageLoaded.value
                                  ? 1.0
                                  : 0.0,
                              duration: const Duration(milliseconds: 300),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 180.0),
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
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              sliver: SliverToBoxAdapter(
                child: SizedBox(
                    width: double.infinity,
                    height: 65,
                    child: StarRating(sizeIcon: 40, rating: movie.rating)),
              ),
            ),
            const SliverToBoxAdapter(
              child: Center(
                child: Text(
                  "Opis",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
            SliverPadding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    movie.overview,
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    height: 200.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: castList.data!.length,
                          separatorBuilder: (context, index) =>
                              const VerticalDivider(
                            color: Colors.transparent,
                            width: 5,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Text(castList.data![index].name);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
