import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:toast/toast.dart';

class VideoView extends StatefulWidget {
  VideoView({this.videourl, this.songname});
  final String videourl;
  final String songname;
  @override
  _VideoView createState() => _VideoView();
}

class _VideoView extends State<VideoView> {
  VideoPlayerController _controller;
  bool _isplaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videourl)
      ..initialize().then((_) {
        setState(() {
          _isplaying = true;
        });
        _controller.play();
        _controller.setLooping(true);
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
        child: Stack(children: [
          InkWell(
              onTap: () => _toggleVideo(),
              child: Center(
                child: _controller.value.initialized
                    ? DecoratedBox(
                    position: DecorationPosition.foreground,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Colors.black87, Colors.transparent])),
                    child: AspectRatio(
                      aspectRatio: 0.48,
                      child: VideoPlayer(_controller),
                    ))
                    : Container(
                    child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ))),
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Container()),
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                child: Text(
                  widget.songname,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                      color: Colors.white),
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
                  child: Text(
                    "Song taken from youtube not my animation or song",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ]));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}