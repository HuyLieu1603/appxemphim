import 'dart:io';
import 'package:appxemphim/data/API/api.dart';
import 'package:appxemphim/data/model/movies.dart';
import 'package:appxemphim/data/model/movies_continue/movies_continue.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoDetails extends StatefulWidget {
  final String linkMov;
  final Movies objMov;
  final String timeplays;
  const VideoDetails(
      {Key? key,
      required this.linkMov,
      required this.objMov,
      required this.timeplays})
      : super(key: key);
  //const VideoDetails({super.key});
  @override
  State<VideoDetails> createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> {
  //late String linkMovs;
  //String videourl = "https://www.youtube.com/watch?v=n9xhJrPXop4";
  late YoutubePlayerController _controller;
  Duration? videoDuration;
  bool isFullscreen = false;
  //late MoviesContinue testdemo;
  String nameid = "";
  late String times;
  late Future<String> _loadshare;
  late Future<MoviesContinue> demo;
  int timeplay = 0;
  var takedata;
  Future<String> loadshare() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nameid = prefs.getString('name').toString();
    return nameid;
  }

  Future<String> test() async {
    print(widget.objMov.id.toString().trim() + " ne");
    print(nameid.toString().trim() + " ne");
    print(times + " ne");
    await APIResponsitory().Moviescontinues(
        widget.objMov.id.toString().trim(), nameid.toString().trim(), times);

    return '';
  }

  @override
  void initState() {
    super.initState();
    _loadshare = loadshare();

    //linkMovs = widget.linkMov;
    /* if (linkMovs == "") {
      linkMovs = "https://www.youtube.com/watch?v=wr33qdjMV9c";
    }*/
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
    print("cai nay truoc");
    print(widget.timeplays.toString());
    print("cai nay truoc");
    final videoID = YoutubePlayer.convertUrlToId(widget.linkMov.toString());
    bool controlVisible = true;
    _controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: YoutubePlayerFlags(
        startAt: int.parse(widget.timeplays.toString()),
        hideThumbnail: true,
        enableCaption: true,
        captionLanguage: 'en',
        autoPlay: true,
        disableDragSeek: true,
        loop: true,
        forceHD: true,
        useHybridComposition: true,
        showLiveFullscreenButton: true,
      ),
    )..addListener(() {
        if (_controller.value.isReady) {
          setState(() {
            videoDuration = _controller.value.position;

            times = videoDuration!.inSeconds.toString();

            //print(videoDuration?.inSeconds);
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadshare,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                aspectRatio: 12 / 6,
              ),
              builder: (context, player) {
                return Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.black,
                      iconTheme: IconThemeData(color: Colors.white),
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          loadshare();
                          test();
                          //print(nameid + " idname ne"); // lay dc idname

                          //print(testdemo!.idmovie.toString() + " demio");

                          Navigator.pop(context); // Trở về màn hình trước đó
                          setState(() {
                            //print(loadshare());
                            //print(times + " ne");// lay dc times
                            //print(widget.objMov.id.toString() + " id ne");//lay dc idmovies

                            //print(testdemo.idmovie.toString() + " test demo");

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
                            /*
                            FloatingActionButton(
                              onPressed: () {
                                Duration currentPosition =
                                    _controller.value.position;
                                Duration targetPosition = currentPosition +
                                    const Duration(seconds: 10);
                                _controller.seekTo(targetPosition);
                              },
                              child: const Icon(
                                Icons.arrow_forward,
                              ),
                            ),*/
                          ],
                        ),
                      ),
                    ));
              },
            );
          }
        });
  }
}
