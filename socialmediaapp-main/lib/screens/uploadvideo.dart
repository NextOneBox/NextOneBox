import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class uploadvideo extends StatefulWidget {
  const uploadvideo({Key? key}) : super(key: key);

  @override
  State<uploadvideo> createState() => _uploadvideoState();
}

class _uploadvideoState extends State<uploadvideo> {
  File? video;
  VideoPlayerController? videocontroller;
  String? videoPath; // Added variable to store video path

  Future<void> pickvideofromgallery() async {
    final videopicked = await ImagePicker().pickVideo(
        source: ImageSource.gallery, maxDuration: const Duration(seconds: 60));
    if (videopicked != null) {
      video = File(videopicked.path);
      videoPath = videopicked.path; // Store video path
   

      print('Video uploaded .');
      var uri = Uri.parse('https://shorts.nextonebox.com/upload_video/');  // Replace with the URL of the server endpoint

      var request = http.MultipartRequest('POST', uri);
      
      // Add video file
      var videoStream = http.ByteStream(Stream.castFrom(video!.openRead()));
      var videoLength = await video!.length();
      var videoMultipartFile = http.MultipartFile('video', videoStream, videoLength,
          filename: video!.path.split('/').last);
      request.files.add(videoMultipartFile);

      var response = await request.send();

      if (response.statusCode == 200) {
        print('Video uploaded successfully');
      } else {
        print('Failed to upload the video. Status code: ${response.statusCode}');
      }





    // var uri = Uri.parse('https://shorts.nextonebox.com/Video/');  // Replace with your server URL
    
    // var request = http.MultipartRequest('POST', uri);
    // // request.fields['user'] = 'shahid';
    // // request.fields['title'] = 'Static title';
    // // request.fields['desc'] = 'Static description';
    // // request.fields['category'] = 'Static category';
    
    // var videoStream = http.ByteStream(video!.openRead());
    // var videoLength = await video!.length();
    
    // var videoMultipartFile = http.MultipartFile(
    //   'video_file',
    //   videoStream,
    //   videoLength,
    //   filename: 'videopath.mp4',
    // );
    
    // request.files.add(videoMultipartFile);
    
    // var response = await request.send();
    
    // if (response.statusCode == 200) {
    //   print('Video uploaded successfully');
    // } else {
    //   print('Failed to upload video. Error: ${response.reasonPhrase}');
    // }

    videocontroller = VideoPlayerController.file(video!)
            ..initialize().then((_) {
              setState(() {});
              videocontroller!.play();
              videocontroller!.setLooping(true);
            });
    }






   
  
  }

  Future<void> pickvideofromcamera() async {
    final videopicked = await ImagePicker().pickVideo(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
        maxDuration: const Duration(seconds: 60));
    if (videopicked != null) {
      video = File(videopicked.path);
      videoPath = videopicked.path; // Store video path
      videocontroller = VideoPlayerController.file(video!)
        ..initialize().then((_) {
          setState(() {});
          videocontroller!.play();
          videocontroller!.setLooping(true);
        });
    }
  }

  @override
  void initState() {
    // pickvideofromgallery();
    super.initState();
  }

  @override
  void dispose() {
    videocontroller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Video Picker App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            video == null
                ? const SizedBox(
                    height: 400,
                    width: 300,
                    child: Placeholder(),
                  )
                : ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxHeight: 400, maxWidth: 300),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {});
                        videocontroller!.value.isPlaying
                            ? videocontroller!.pause()
                            : videocontroller!.play();
                      },
                      child: AspectRatio(
                        aspectRatio: videocontroller!.value.aspectRatio,
                        child: Stack(
                          children: [
                            VideoPlayer(videocontroller!),
                            Center(
                              child: videocontroller!.value.isPlaying
                                  ? const SizedBox()
                                  : SizedBox.square(
                                      dimension: 100,
                                      child: Image.asset('assets/playicon.png'),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton.icon(
              onPressed: () => pickvideofromgallery(),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(220, 50)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
                backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
              ),
              icon: SizedBox.square(
                dimension: 35,
                child: Image.asset('assets/video.png'),
              ),
              label: const Text(
                'Pick Video',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              onPressed: () => pickvideofromcamera(),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(220, 50)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
                backgroundColor: MaterialStateProperty.all(
                  Color.fromARGB(255, 17, 180, 131),
                ),
              ),
              icon: SizedBox.square(
                dimension: 35,
                child: Image.asset('assets/camera.png'),
              ),
              label: const Text(
                'Record Video',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            const SizedBox(height: 20),
            if (videoPath != null)
              Text('Video Path: $videoPath'),
          ],
        ),
      ),
    );
  }
}









// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:video_player/video_player.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   File? video;
//   VideoPlayerController? videocontroller;
//   Future<void> pickvideofromgallery() async {
//     final videopicked = await ImagePicker().pickVideo(
//         source: ImageSource.gallery, maxDuration: const Duration(seconds: 60));
//     if (videopicked != null) {
//       video = File(videopicked.path);
//     print('firststep');
//     print(video.toString());
//     print('firststep');
//     var stream  = new http.ByteStream(video!.openRead());
//     stream.cast();
//   var length = await File(video as String).length();
//     // var length = await  video!.length();
//     print('secondstep');
//     var uri = Uri.parse('https://shorts.nextonebox.com/PostVideo/');

//     var request = http.MultipartRequest('POST', uri);
//     request.fields['user'] = "info@nextonebox.com" ;
//     request.fields['title'] = "Static title" ;
//     request.fields['desc'] = "Static title" ;
//     request.fields['cate'] = "Static title" ;
//     print('thirdstep');
//     var video_file = new http.MultipartFile(
//         'video',
//         stream,
  
//         length);
//     print('fourthtep');
//     request.files.add(video_file);

//     var response = await request.send() ;
//     print(response..stream.toString());
 

//       videocontroller = VideoPlayerController.file(video!)
//         ..initialize().then((_) {
//           setState(() {});
//           videocontroller!.play();
//           videocontroller!.setLooping(true);
//         });
//     }
//   }

//   Future<void> pickvideofromcamera() async {
//     final videopicked = await ImagePicker().pickVideo(
//         source: ImageSource.camera,
//         preferredCameraDevice: CameraDevice.rear,
//         maxDuration: const Duration(seconds: 60));
//     if (videopicked != null) {
//       video = File(videopicked.path);
//       videocontroller = VideoPlayerController.file(video!)
//         ..initialize().then((_) {
//           setState(() {});
//           videocontroller!.play();
//           videocontroller!.setLooping(true);
//         });
//     }
//   }

//   @override
//   void initState() {
//     pickvideofromgallery();
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   void dispose() {
//     videocontroller!.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.red,
//           title: const Text('Video Picker App'),
//         ),
//         body: Center(
//             child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             video == null
//                 ? const SizedBox(
//                     height: 400,
//                     width: 300,
//                     child: Placeholder(),
//                   )
//                 : ConstrainedBox(
//                     constraints:
//                         const BoxConstraints(maxHeight: 400, maxWidth: 300),
//                     child: GestureDetector(
//                       onTap: () {
//                         setState(() {});
//                         videocontroller!.value.isPlaying
//                             ? videocontroller!.pause()
//                             : videocontroller!.play();
//                       },
//                       child: AspectRatio(
//                         aspectRatio: videocontroller!.value.aspectRatio,
//                         child: Stack(children: [
//                           VideoPlayer(videocontroller!),
//                           Center(
//                               child: videocontroller!.value.isPlaying
//                                   ? const SizedBox()
//                                   : SizedBox.square(
//                                       dimension: 100,
//                                       child:
//                                           Image.asset('assets/playicon.png')))
//                         ]),
//                       ),
//                     ),
//                   ),
//             const SizedBox(
//               height: 30,
//             ),
//             ElevatedButton.icon(
//                 onPressed: () => pickvideofromgallery(),
//                 style: ButtonStyle(
//                     minimumSize: const MaterialStatePropertyAll(Size(220, 50)),
//                     shape: MaterialStatePropertyAll(RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10))),
//                     backgroundColor:
//                         const MaterialStatePropertyAll(Colors.deepOrange)),
//                 icon: SizedBox.square(
//                   dimension: 35,
//                   child: Image.asset('assets/video.png'),
//                 ),
//                 label: const Text(
//                   'Pick Video',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
//                 )),
//             const SizedBox(
//               height: 10,
//             ),
//             ElevatedButton.icon(
//                 onPressed: () => pickvideofromcamera(),
//                 style: ButtonStyle(
//                     minimumSize: const MaterialStatePropertyAll(Size(220, 50)),
//                     shape: MaterialStatePropertyAll(RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10))),
//                     backgroundColor: const MaterialStatePropertyAll(
//                         Color.fromARGB(255, 17, 180, 131))),
//                 icon: SizedBox.square(
//                   dimension: 35,
//                   child: Image.asset('assets/camera.png'),
//                 ),
//                 label: const Text(
//                   'Record Video',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
//                 )),
//           ],
//         )));
//   }
// }
