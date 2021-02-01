import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tafseer_app/constants.dart';
import 'package:tafseer_app/screens/SurahTafseer/SurahTafseer.dart';
import 'package:tafseer_app/services/TafseerAPI.dart';

class Surah_details extends StatefulWidget {
  const Surah_details({
    Key key,
    // ignore: non_constant_identifier_names
    this.surah_name,
    this.surah_num,
    this.num_of_Ayahs,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  // ignore: non_constant_identifier_names
  final String surah_name;
  final int surah_num;
  final int num_of_Ayahs;
  final double width;
  final double height;

  @override
  _Surah_detailsState createState() => _Surah_detailsState();
}

class _Surah_detailsState extends State<Surah_details> {
  List<String> ayah = [];
  List<String> responses = [];
  List<Tafseer> instances = [];

  void loadAyahs() {
    for (var i = 1; i <= {widget.num_of_Ayahs}.first; i++) {
      instances.add(Tafseer(url: '${widget.surah_num + 1}/$i'));
    }
    Future.wait(instances.map((instance) => instance.getAyah()).toList())
        .then((void v) {
      responses =
          responses + instances.map((instance) => instance.ayah).toList();
      setState(() {
        ayah = responses;
      });
    });
  }

  List<InlineSpan> ayahTransform(List ayahs) {
    var children = <InlineSpan>[];
    for (var i = 0; i < ayahs.length; i++) {
      children.add(
        TextSpan(
          text: ayahs[i],
          //softWrap: false,
          style: TextStyle(
            wordSpacing: 4,
            fontSize: 25,
            fontFamily: 'QuraanFont',
            color: kTextColor,
          ),
        ),
      );
      children.add(WidgetSpan(
          child: SizedBox(
        width: 10,
      )));
      children.add(
        TextSpan(
          text: '${i + 1}',
          //softWrap: false,
          style: TextStyle(
            background: Paint()
              ..color = kPrimaryColor
              ..style = PaintingStyle.fill,
            fontSize: 20,
            fontFamily: 'QuraanFont',
          ),
        ),
      );
      children.add(WidgetSpan(
          child: SizedBox(
        width: 10,
      )));
    }
    return children;
  }

  @override
  void initState() {
    super.initState();
    loadAyahs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                child: SvgPicture.asset('Assets/Quran.svg'),
              )),
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: widget.height * 0.08,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SurahTafseer(),
                        ),
                      );
                    },
                    child: Center(
                        child: Text(
                      'سورة ${widget.surah_name}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 34,
                          fontFamily: 'Tajawal',
                          color: kTextColor),
                    ))),
                /*Center(
                    child: Text(
                  '1',
                  style: TextStyle(
                      fontSize: 80, fontFamily: 'Tajawal', color: kTextColor),
                )),*/
                Flexible(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10.0),
                        child: RichText(
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                            text: TextSpan(children: ayahTransform(ayah))),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
