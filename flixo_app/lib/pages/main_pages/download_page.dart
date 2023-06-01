import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../provider/movie.dart';
import '../../provider/video_provider.dart';

final animatedListKey = GlobalKey<AnimatedListState>();

class DownLoadPage extends HookConsumerWidget {
  static const routName = "/downl";

  const DownLoadPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void downloadVideo(
      BuildContext context,
      WidgetRef ref,
    ) async {
      // Replace with your video URL
      final String url =
          'https://firebasestorage.googleapis.com/v0/b/caffee-2e82e.appspot.com/o/Brutalna%20scena%20usuni%C4%99ta%20z%20Gwiezdnych%20wojen.%20Dlaczego%20bano%20si%C4%99%20pokaza%C4%87%20j%C4%85%20widzom_%20Star%20Wars%20Historie.mp4?alt=media&token=a9b43d17-74e9-4632-b298-f8235561755a&_gl=1*1h64845*_ga*Njg5MTk0MDExLjE2Nzg5Njk4Mzc.*_ga_CW55HF8NVT*MTY4NTY0MDcwMi4zLjEuMTY4NTY0MTQ2OS4wLjAuMA..';
      final request = http.Request('GET', Uri.parse(url));
      final response = await request.send();

      // Get the total size of the file
      final totalBytes = response.contentLength;

      // Create a stream to track the progress of the download
      final bytesStream = response.stream.asBroadcastStream();
      int bytesReceived = 0;
      bytesStream.listen((chunk) {
        // Update the number of bytes received
        bytesReceived += chunk.length;

        // Calculate the progress of the download
        final progress = bytesReceived / totalBytes!;

        // Update the progress using your provider
        ref.read(downloadProgressProvider.notifier).updateProgress(progress);
      });

      // Save the file to disk
      final status = await Permission.storage.request();
      if (status.isGranted) {
        final externalDir = await getExternalStorageDirectory();
        final file = File('${externalDir!.path}/vader.mp4');
        await file.create(recursive: true);
        await for (final chunk in bytesStream) {
          file.writeAsBytesSync(chunk, mode: FileMode.append);
        }
      } else {
        // Handle permission denied
      }
    }

    final movieList = ref.watch(movieListProvider);

    final progress = ref.watch(downloadProgressProvider);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedList(
        key: animatedListKey,
        initialItemCount: movieList.length,
        itemBuilder: (context, index, animation) {
          final movie = movieList[index];
          return FadeTransition(
            opacity: animation,
            child: SizeTransition(
              sizeFactor: animation,
              axis: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                            height: 180,
                            width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: CachedNetworkImageProvider(
                                  'http://image.tmdb.org/t/p/w500${movie.posterPath}',
                                ),
                              ),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: Stack(
                                    children: [
                                      Text(
                                        movie.title,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Positioned(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        bottom: 10,
                                        child: IconButton(
                                            onPressed: () {
                                              deleteMovie(ref, index);
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                  height: 30,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      elevatedButtonTheme:
                                          ElevatedButtonThemeData(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                        ),
                                      ),
                                    ),
                                    child: ElevatedButton.icon(
                                        label: const Text(
                                          'Click to Start Download',
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white),
                                        ),
                                        onPressed: () =>
                                            downloadVideo(context, ref),
                                        icon: const Icon(
                                          Icons.download_for_offline_outlined,
                                          color: Colors.white,
                                        )),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: LinearProgressIndicator(
                                    minHeight: 10,
                                    value:
                                        progress, // You'll need to define the progress variable
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ).animate().fadeIn(),
            ),
          );
        },
      ),
    );
  }

  void deleteMovie(WidgetRef ref, int index) {
    animatedListKey.currentState
        ?.removeItem(index, (context, animation) => Container());
    ref.read(movieListProvider.notifier).deleteMovie(index);
  }
}
