import 'package:flutter/material.dart';
import 'package:LofiPlayer/widgets/videoview.dart';

class HomeView extends StatefulWidget {
  HomeView({this.songs});
  final List songs;
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
            videourl: song['url'],
            songname: song['title'],
          ))
              .toList())
    ]);
  }
}
