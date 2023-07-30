// ignore_for_file: prefer_const_constructors

import 'package:cashapp/ComonScreens/widgets.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Video {
  final String videoId;

  Video(this.videoId);
}

final videoi = videos!.values.toList().reversed;

class VideoPlayerPage extends StatelessWidget {
  final video = List.from(videoi);

  @override
  Widget build(BuildContext context) {
    print(video);
    return Scaffold(
      appBar: AppBar(
        title: Text('How to Earn'),
      ),
      body: ListView.builder(
        itemCount: video.length,
        itemBuilder: (context, index) {
          final vide = video[index]['video'];
          print(vide);
          return VideoPlayerWidget(videoId: vide);
        },
      ),
    );
  }
}

class VideoPlayerWidget extends StatelessWidget {
  final videoId;

  VideoPlayerWidget({required this.videoId});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(20.0),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: YoutubePlayer(
          controller: YoutubePlayerController(
            initialVideoId: videoId,
            flags: YoutubePlayerFlags(
              hideControls: false, // Set this to true to hide video controls
              controlsVisibleAtStart:
                  false, // Set this to false to hide controls initially
              hideThumbnail:
                  false, // Hide the video thumbnail when video starts
              autoPlay: false,
            ),
          ),
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
          progressColors: ProgressBarColors(
            playedColor: Colors.blueAccent,
            handleColor: Colors.blueAccent,
          ),
          onReady: () {
            // Implement your logic here when the player is ready to play.
          },
        ),
      ),
    );
  }
}
