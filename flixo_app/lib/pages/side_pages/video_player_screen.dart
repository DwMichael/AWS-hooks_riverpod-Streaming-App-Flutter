import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends HookConsumerWidget {
  VideoPlayerScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controller = useState<VideoPlayerController?>(null);
    final _initializeVideoPlayerFuture = useState<Future<void>?>(null);

    useEffect(() {
      _controller.value = VideoPlayerController.network(
          'https://d1g8hloj55af01.cloudfront.net/vods/kings_of_la_trailer_1_h1080p/mp4/kings_of_la_trailer_1_h1080p.mp4');
      _initializeVideoPlayerFuture.value = _controller.value!.initialize();

      return () {
        _controller.value?.dispose();
      };
    }, []);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.black)),
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture.value,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: AspectRatio(
                aspectRatio: _controller.value!.value.aspectRatio,
                child: VideoPlayer(_controller.value!),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.value!.value.isPlaying
              ? _controller.value!.pause()
              : _controller.value!.play();
        },
        child: Icon(
          _controller.value!.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
