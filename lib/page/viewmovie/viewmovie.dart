import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoDetails extends StatefulWidget {
  final String linkMov;

  const VideoDetails({Key? key, required this.linkMov}) : super(key: key);

  @override
  State<VideoDetails> createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> {
  late String linkMov;
  //String videourl = "https://www.youtube.com/watch?v=n9xhJrPXop4";
  late YoutubePlayerController _controller;
  Duration? videoDuration;
  bool isFullscreen = false;
  @override
  void initState() {
    super.initState();

    linkMov = widget.linkMov;
    if (linkMov == "") {
      linkMov = "https://www.youtube.com/watch?v=wr33qdjMV9c";
    }
    SystemChrome.setPreferredOrientations(
  [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
);
    final videoID = YoutubePlayer.convertUrlToId(linkMov);
    _controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: const YoutubePlayerFlags(
        startAt: 0,
        hideThumbnail: true,
        enableCaption: true,
        captionLanguage: 'en',
        autoPlay: true,
      ),
    )..addListener(() {
        if (_controller.value.isReady) {
          setState(() {
            videoDuration = _controller.value.position;
            
            print(videoDuration?.inSeconds);
            
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
      ),
      builder: (context, player) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              iconTheme: IconThemeData(color: Colors.white),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context); // Trở về màn hình trước đó
                  setState(() {
                    // Cập nhật trạng thái (state) nếu cần thiết
                  });
                },
              ),
            ),
            body: Container(
              decoration: BoxDecoration(color: Colors.black),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: player,
                    ),
                    Text(
                      'Video Duration: ${videoDuration?.toString() ?? "Unknown"}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
