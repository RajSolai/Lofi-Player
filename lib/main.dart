import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _App createState() => _App();
}

class _App extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SplashView());
  }
}

class HomeView extends StatefulWidget {
  HomeView({this.songs});
  final List<Map> songs;
  @override
  _HomeView createState() => _HomeView();
}

class _HomeView extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      PageView(
          scrollDirection: Axis.vertical,
          children: widget.songs
              .map((song) => VideoView(
                    videourl: song['uri'],
                    songname: song['title'],
                  ))
              .toList())
    ]);
  }
}

class SplashView extends StatefulWidget {
  @override
  _SplashView createState() => _SplashView();
}

class _SplashView extends State<SplashView> {
  bool _isLoading = true;
  var songs = [
    {
      "title": "Jinsang- Affection",
      "uri":
          "https://firebasestorage.googleapis.com/v0/b/pushy-9740f.appspot.com/o/vid1.mp4?alt=media&token=76c433ed-b909-44c9-ba42-31dc4b95f825"
    },
    {
      "title": "Saib- In your arms",
      "uri":
          "https://firebasestorage.googleapis.com/v0/b/pushy-9740f.appspot.com/o/vid2.mp4?alt=media&token=162b6b2e-4abf-4f83-88a1-e48bae40d966"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: _isLoading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "LofiPlayer",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 32.0),
                    ),
                    Padding(
                      padding: EdgeInsets.all(40.0),
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                    ElevatedButton(
                      child: Text("Debug"),
                      onPressed: () => setState(() {
                        _isLoading = false;
                      }),
                    )
                  ],
                ),
              )
            : HomeView(
                songs: songs,
              ));
  }
}

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
