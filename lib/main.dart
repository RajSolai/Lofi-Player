import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

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
        body: PageView(
          scrollDirection: Axis.vertical,
          children: [
            VideoView(),
            VideoView()
          ],
        ),
      ),
    );
  }
}

class VideoView extends StatefulWidget {
  @override
  _VideoView createState() => _VideoView();
}

class _VideoView extends State<VideoView> {
  VideoPlayerController _controller;
  bool _isplaying = false;
  String _videoPath = "assets/sample.mp4";

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(_videoPath)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {_isplaying = true;});
        _controller.play();
      });
  }
  void _toggleVideo() {
    if(_isplaying){
      _controller.pause();
      setState((){_isplaying=false;});
    }else{
      _controller.play();
      setState((){_isplaying=true;});
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: ()=>_toggleVideo(),
      child:Center(
          child: _controller.value.initialized
              ? AspectRatio(
                  aspectRatio: 0.45,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        )
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
