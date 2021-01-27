import 'package:http/http.dart';
import 'dart:convert';

class Tafseer {
  String ayah;
  String url;

  Tafseer({this.ayah, this.url});

  Future<void> getAyah() async {
    // make the request
    Response response = await get('http://api.quran-tafseer.com/quran/$url');
    Map data = json.decode(utf8.decode(response.bodyBytes));
    ayah = data['text'];
    print(ayah);
  }
}
