// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
//
// class DownloadButton extends StatefulWidget {
//   @override
//   _DownloadButtonState createState() => _DownloadButtonState();
// }
//
// class _DownloadButtonState extends State<DownloadButton> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ElevatedButton(
//             onPressed: () => openFile(
//                 url: 'https://jo-students.com/site_videos/1_3_RecordedLive.mp4',
//                 fileName: 'video.mp4'),
//             child: const Text('Download Video'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future openFile({required String url, String? fileName}) async {
//     final file = await downloadFile(url, fileName!);
//     if (file == null) return;
//     print('Path: ${file.path}');
//     OpenFile.open(file.path);
//   }
//
//   Future<File?> downloadFile(String url, String name) async {
//     final appStorage = await getApplicationDocumentsDirectory();
//     final file = File('${appStorage.path}/$name');
//
//     try {
//       final response = await Dio().get(
//         url,
//         options: Options(
//           responseType: ResponseType.bytes,
//           followRedirects: true, // Allow following redirects
//           maxRedirects: 5, // Limit the number of redirects
//           receiveTimeout: const Duration(seconds: 0),
//         ),
//       );
//
//       final raf = file.openSync(mode: FileMode.write);
//       raf.writeFromSync(response.data);
//       await raf.close();
//       return file;
//     } catch (e) {
//       print("ERROR $e");
//       return null;
//     }
//   }
// }


import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class VideoDownloader extends StatefulWidget {
  @override
  _VideoDownloaderState createState() => _VideoDownloaderState();
}

class _VideoDownloaderState extends State<VideoDownloader> {
  ChewieController? _chewieController;
  VideoPlayerController? _videoPlayerController;
  bool _isVideoLoaded = false;
  bool _isLoading = false; // Track loading state
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Video Downloader')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true; // Set loading state to true
                });
                final file = await downloadVideo(
                  url: 'https://jo-students.com/site_videos/1_42_RecordedLive.mp4?logintrx=HKf2717LtrhWetEZivBTwTy1Lp6uEN98OCvnoB+/SAgntSwF/VETNC8hf8FNIX2nBB269pRIuq/IV/0JqQcVzNox9aznSb+t',
                  fileName: 'RecordedLive.mp4',
                );
                setState(() {
                  _isLoading = false; // Set loading state to false
                });
                if (file != null) {
                  await _initializeVideoPlayer(file);
                }
              },
              child: const Text('Download and View Video'),
            ),
            if (_isLoading)
              CircularProgressIndicator(), // Show loading indicator
            if (_isVideoLoaded && _chewieController != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: AspectRatio(
                  aspectRatio: _videoPlayerController?.value.aspectRatio ?? 1.0,
                  child: Chewie(controller: _chewieController!),
                ),
              ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _initializeVideoPlayer(File file) async {
    try {
      _videoPlayerController = VideoPlayerController.file(file);
      await _videoPlayerController!.initialize();

      if (_videoPlayerController!.value.isInitialized) {
        setState(() {
          _chewieController = ChewieController(
            videoPlayerController: _videoPlayerController!,
            autoPlay: true,
            looping: true,
          );
          _isVideoLoaded = true;
          _errorMessage = null; // Clear any previous error
        });
        print("Video Player Initialized Successfully");
      } else {
        setState(() {
          _errorMessage = "Video player failed to initialize.";
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to initialize video player: $e";
      });
      print("Failed to initialize video player: $e");
    }
  }

  Future<File?> downloadVideo({required String url, required String fileName}) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$fileName');

    try {
      final response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: true,
          maxRedirects: 5,
        ),
      );

      if (response.statusCode == 200) {
        // Write the video to the file
        final raf = file.openSync(mode: FileMode.write);
        raf.writeFromSync(response.data);
        await raf.close();

        // Check if the file was downloaded successfully
        if (await file.exists()) {
          print("File downloaded successfully: ${file.path}");
          return file;
        } else {
          print("File not found after download.");
          return null;
        }
      } else {
        print("Failed to download video. Status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("ERROR: $e");
      return null;
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
}









