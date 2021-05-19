import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

void main() => runApp(HomePage());

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              PageView(
                scrollDirection: Axis.vertical,
                children: [
                  VideoView(videourl: "assets/vid1.mp4"),
                  VideoView(videourl: "assets/vid2.mp4")
                ],
              ),
              SongDetailsView(),
            ],
          )),
    );
  }
}

class SongDetailsView extends StatefulWidget {
  @override
  _SongDetailsView createState() => _SongDetailsView();
}

class _SongDetailsView extends State<SongDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Container()),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "Song Name",
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                  color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

class VideoView extends StatefulWidget {
  VideoView({this.videourl});
  final String videourl;
  @override
  _VideoView createState() => _VideoView();
}

class _VideoView extends State<VideoView> {
  VideoPlayerController _controller;
  bool _isplaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videourl)
      ..initialize().then((_) {
        setState(() {
          _isplaying = true;
        });
        _controller.play();
      });
  }

  void _toggleVideo() {
    if (_isplaying) {
      _controller.pause();
      Toast.show("⏸️", context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      setState(() {
        _isplaying = false;
      });
    } else {
      _controller.play();
      Toast.show("▶️", context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      setState(() {
        _isplaying = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: InkWell(
            onTap: () => _toggleVideo(),
            child: Center(
              child: _controller.value.initialized
                  ? AspectRatio(
                      aspectRatio: 0.45,
                      child: VideoPlayer(_controller),
                    )
                  : Container(),
            )));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
