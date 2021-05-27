import 'dart:convert';
import 'package:http/http.dart' as http;

class Videos {
  List videoLists;

  final Uri apiLink = Uri.parse("https://lofi-api-rajsolai.herokuapp.com/api");

  Future<List> getVideos() async {
    await http.get(apiLink).then((res) => {videoLists = json.decode(res.body)});
    return videoLists;
  }
}
