import 'package:http/http.dart';
import 'dart:convert';

class Tafseer {
  String ayah;
  String url;
  String tafseer;
  Tafseer({this.ayah, this.url, this.tafseer});

  Future<void> getAyah() async {
    // make the request
    try {
      Response response = await get('http://api.quran-tafseer.com/quran/$url');
      Map data = json.decode(utf8.decode(response.bodyBytes));

      ayah = data['text'];
    } catch (e) {
      print('couldnot');
    }
  }

  Future<void> getTafseer() async {
    // make the request
    try {
      Response response =
          await get('http://api.quran-tafseer.com/tafseer/$url');
      Map data = json.decode(utf8.decode(response.bodyBytes));
      tafseer = data['text'];
    } catch (e) {
      print('couldnot');
    }
  }
}
