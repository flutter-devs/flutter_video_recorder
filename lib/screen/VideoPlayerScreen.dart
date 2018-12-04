import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  String path;

  VideoPlayerScreen(this.path);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState(path);
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController playerController;
  VoidCallback listener;
  String path;

  BuildContext context;

  _VideoPlayerScreenState(this.path);

  @override
  @override
  void initState() {
    super.initState();

    listener = () {
    };
    initializeVideo();
    playerController.play();
  }

  void initializeVideo() {
    playerController = VideoPlayerController.file(File(path))
      ..addListener(listener)
      ..setVolume(1.0)
      ..initialize()
      ..play();
  }

  @override
  void deactivate() {
    if (playerController != null) {
      playerController.setVolume(0.0);
      playerController.removeListener(listener);
    }
    super.deactivate();
  }

  @override
  void dispose() {
    if (playerController != null) playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
        appBar: new AppBar(
          title: Text('Video Player'),
        ),
        body: Stack(fit: StackFit.expand, children: <Widget>[
          new AspectRatio(
              aspectRatio: 9 / 16,
              child: Container(
                child: (playerController != null
                    ? VideoPlayer(
                        playerController,
                      )
                    : Container()),
              )),
        ]));
  }
}
