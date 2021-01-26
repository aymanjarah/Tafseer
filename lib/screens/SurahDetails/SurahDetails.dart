import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tafseer_app/constants.dart';
import 'package:tafseer_app/screens/SurahTafseer/SurahTafseer.dart';

class Surah_details extends StatefulWidget {
  const Surah_details({
    Key key,
    this.surah_name,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  final String surah_name;
  final double width;
  final double height;

  @override
  _Surah_detailsState createState() => _Surah_detailsState();
}

class _Surah_detailsState extends State<Surah_details> {
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
                Center(
                    child: Text(
                  '1',
                  style: TextStyle(
                      fontSize: 80, fontFamily: 'Tajawal', color: kTextColor),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
