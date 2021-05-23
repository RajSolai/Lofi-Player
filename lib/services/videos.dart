import 'dart:convert';

import 'package:http/http.dart' as http;

class Videos {
  final Uri apiLink = Uri.parse("https://lofi-api-rajsolai.herokuapp.com/api");
  Future<List> getVideos() async{
    List out;
    await http.get(apiLink).then((res) => {
      out = json.decode(res.body)
    });
    return out;
  }
}
