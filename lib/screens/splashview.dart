import 'package:flutter/material.dart';
import 'package:LofiPlayer/services/videos.dart';
import 'package:LofiPlayer/screens/homeview.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashView createState() => _SplashView();
}

class _SplashView extends State<SplashView> {
  bool _isLoading = true;
  List vids;

  @override
  void initState() {
    super.initState();
    new Videos().getVideos().then((value) => {
      setState((){
        vids = value;
        _isLoading = false;
      })
    });
  }

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
              )
            ],
          ),
        )
            : HomeView(
          songs: vids,
        ));
  }
}