import 'package:flutter/material.dart';
import 'package:topg/screens/widget.dart';
import 'package:video_player/video_player.dart';

class ShortPlayerScreen extends StatefulWidget {
  @override
  _ShortPlayerScreenState createState() => _ShortPlayerScreenState();
}

class _ShortPlayerScreenState extends State<ShortPlayerScreen> {
  List<String> videoUrls = [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  ];
  int currentVideoIndex = 0;
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
        videoUrls[currentVideoIndex],
        videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true))
      ..initialize().then((_) {
        setState(() {
          _videoPlayerController.play();
        });
      });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void playNextVideo() {
    if (currentVideoIndex < videoUrls.length - 1) {
      currentVideoIndex++;
      _videoPlayerController =
          VideoPlayerController.network(videoUrls[currentVideoIndex])
            ..initialize().then((_) {
              setState(() {
                _videoPlayerController.play();
              });
            });
    }
  }

  void replayCurrentVideo() {
    if (currentVideoIndex > 1) {
      currentVideoIndex--;
      _videoPlayerController =
          VideoPlayerController.network(videoUrls[currentVideoIndex])
            ..initialize().then((_) {
              setState(() {
                _videoPlayerController.play();
              });
            });
    } else {
      _videoPlayerController.seekTo(Duration.zero);
      setState(() {
        _videoPlayerController.play();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool like = false;
    return SafeArea(
      child: Scaffold(
        backgroundColor: c6,
        body: GestureDetector(
          onVerticalDragEnd: (details) {
            if (details.velocity.pixelsPerSecond.dy < 0) {
              playNextVideo();
            } else if (details.velocity.pixelsPerSecond.dy > 0) {
              replayCurrentVideo();
            }
          },
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Center(
                child: _videoPlayerController.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: 9 / 17,
                        child: GestureDetector(
                            onTap: () {
                              _videoPlayerController.pause();
                            },
                            onDoubleTap: () {
                              _videoPlayerController.play();
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: VideoPlayer(_videoPlayerController))),
                      )
                    : CircularProgressIndicator(),
              ), 
              VideoProgressIndicator(
                _videoPlayerController,
                allowScrubbing: true,
                // padding: EdgeInsets.all(8),
              ),
              Positioned(
                right: 0,
                bottom: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      iconSize: 30,
                      color: c3,
                      icon: Icon(Icons.favorite),
                      onPressed: () {
                        setState(() {
                          like = true;
                        });
                        // Perform like action
                      },
                    ),
                    SizedBox(height: 10),
                    IconButton(
                      iconSize: 30,
                      color: c3,
                      icon: Icon(Icons.comment),
                      onPressed: () {
                        
                      },
                    ),
                    SizedBox(height: 10),
                    IconButton(
                      iconSize: 30,
                      color: c3,
                      icon: Icon(Icons.mobile_screen_share_outlined),
                      onPressed: () {
                        // Perform share action
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 40,
                left: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRF5g7uomoAMZ1pO14mMV-IsrF0DSCBEG2XVQ&usqp=CAU'),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'sonam',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Perform follow action
                      },
                      child: Text('Follow'),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 20,
                left: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'hellow this is my first vlog i love to share with you',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
