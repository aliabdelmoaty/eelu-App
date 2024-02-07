import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatelessWidget {
  const VideoPlayer({super.key, required this.title, required this.urlVideo});

  final String title ;
  final String urlVideo;

  @override
  Widget build(BuildContext context) {
    String? videoId;
    videoId = YoutubePlayer.convertUrlToId(
        urlVideo)!;
    return Scaffold(
        appBar: AppBar(
          title:  Text(title),
        ),
        body: SizedBox(
          width: double.infinity,
          child: YoutubePlayer(
            
            controller: YoutubePlayerController(
              initialVideoId: videoId,
              flags: const YoutubePlayerFlags(
                autoPlay: true,
                mute: false,
              ),
            ),
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.blueAccent,
            progressColors: const ProgressBarColors(
              playedColor: Colors.blue,
              handleColor: Colors.white,
            ),
          ),
        ));
  }
}
