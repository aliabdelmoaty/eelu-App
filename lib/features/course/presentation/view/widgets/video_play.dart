import 'package:flutter/material.dart';
import 'package:payment/features/course/presentation/view/data/cubit/course_cubit.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatelessWidget {
  const VideoPlayer(
      {super.key, required this.title, required this.urlVideo, this.cubit});

  final String title;
  final String urlVideo;
  final CourseCubit? cubit;

  @override
  Widget build(BuildContext context) {
    String? videoId = YoutubePlayer.convertUrlToId(urlVideo);

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          children: [
            YoutubePlay(videoId: videoId),
          ],
        ));
  }
}

class YoutubePlay extends StatelessWidget {
  const YoutubePlay({
    super.key,
    required this.videoId,
  });

  final String? videoId;

  @override
  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: YoutubePlayerController(
        initialVideoId: videoId ?? '',
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      ),
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.blueAccent,
      width: double.infinity,
      progressColors: const ProgressBarColors(
        playedColor: Colors.blue,
        handleColor: Colors.white,
      ),
    );
  }
}
