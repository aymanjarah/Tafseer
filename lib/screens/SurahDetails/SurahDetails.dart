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
    @required this.width,
    @required this.height,
  }) : super(key: key);

  // ignore: non_constant_identifier_names
  final String surah_name;
  final double width;
  final double height;

  @override
  _Surah_detailsState createState() => _Surah_detailsState();
}

class _Surah_detailsState extends State<Surah_details> {
  String ayah = '';

  void ayahContent() async {
    Tafseer instance = Tafseer(url: '10/4');
    await instance.getAyah();
    setState(() {
      ayah = instance.ayah;
    });
  }

  @override
  void initState() {
    super.initState();
    ayahContent();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                Center(
                    child: Text(
                  '1',
                  style: TextStyle(
                      fontSize: 80, fontFamily: 'Tajawal', color: kTextColor),
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                      textAlign: TextAlign.justify,
                      textDirection: TextDirection.rtl,
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                          text: ayah,
                          //softWrap: false,
                          style: TextStyle(
                            wordSpacing: 10,
                            fontSize: 23,
                            fontFamily: 'QuraanFont',
                            color: kTextColor,
                          ),
                        ),
                        TextSpan(
                          text: '2',
                          //softWrap: false,
                          style: TextStyle(
                            wordSpacing: 10,
                            fontSize: 23,
                            fontFamily: 'QuraanFont',
                            color: kTextColor,
                          ),
                        ),
                        TextSpan(
                          text: ayah,
                          //softWrap: false,
                          style: TextStyle(
                            wordSpacing: 10,
                            fontSize: 23,
                            fontFamily: 'QuraanFont',
                            color: kTextColor,
                          ),
                        ),
                        TextSpan(
                          text: '2',
                          //softWrap: false,
                          style: TextStyle(
                            wordSpacing: 10,
                            fontSize: 23,
                            fontFamily: 'QuraanFont',
                            color: kTextColor,
                          ),
                        ),

                        /*WidgetSpan(child: AyahWidget(ayah: ayah)),
                    WidgetSpan(child: AyahWidget(ayah: ayah)),
                    WidgetSpan(child: AyahWidget(ayah: ayah)),
                    WidgetSpan(child: AyahWidget(ayah: ayah)),*/
                      ])),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AyahWidget extends StatelessWidget {
  const AyahWidget({
    this.ayahnumber,
    Key key,
    @required this.ayah,
  }) : super(key: key);
  final int ayahnumber;
  final String ayah;

  @override
  Widget build(BuildContext context) {
    return /*Text(
      ayah,
      softWrap: true,
      style: TextStyle(
        fontSize: 23,
        fontFamily: 'QuraanFont',
        color: kTextColor,
      ),
    );*/
        RichText(
            textAlign: TextAlign.justify,
            textDirection: TextDirection.rtl,
            text: TextSpan(children: <TextSpan>[
              //WidgetSpan(child: SizedBox(width: 5)),
              TextSpan(
                text: ayah,
                //softWrap: false,
                style: TextStyle(
                  wordSpacing: 10,
                  fontSize: 23,
                  fontFamily: 'QuraanFont',
                  color: kTextColor,
                ),
              ),
              TextSpan(
                text: '$ayahnumber',
                //softWrap: false,
                style: TextStyle(
                  wordSpacing: 10,
                  fontSize: 23,
                  fontFamily: 'QuraanFont',
                  color: kTextColor,
                ),
              ),

              //WidgetSpan(child: Text('ffff', style: TextStyle(color: Colors.blue))),
            ]));
  }
}
