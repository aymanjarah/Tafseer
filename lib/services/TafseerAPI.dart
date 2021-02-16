import 'package:http/http.dart';
import 'dart:convert';

class Tafseer {
  Map ayahs;
  String url;
  String tafseer;
  Tafseer({this.ayahs, this.url, this.tafseer});

  Future<void> getAyah() async {
    // make the request
    try {
      Response response = await get('https://api.alquran.cloud/v1/surah/$url');

      Map data = json.decode(utf8.decode(response.bodyBytes));

      //print(data);
      ayahs = data;
    } catch (e) {
      print('couldnot ayah');
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
