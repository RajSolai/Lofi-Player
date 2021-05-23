import 'dart:ui';
import 'package:flutter/material.dart';
import 'screens/splashview.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _App createState() => _App();
}

class _App extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "LofiPlayer",
        home: SplashView(),
        theme: ThemeData(
          splashColor: Colors.black,
          backgroundColor: Colors.black,
          accentColorBrightness: Brightness.dark,
          primaryColorBrightness: Brightness.dark
        ),
    );
  }
}


