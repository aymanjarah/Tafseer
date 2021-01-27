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
    Tafseer instance = Tafseer(url: '1/1');
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AyahWidget(
                          ayah: ayah,
                          ayahnumber: 2,
                        ),
                        AyahWidget(
                          ayah: ayah,
                          ayahnumber: 1,
                        ),
                      ],
                    )),
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
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Transform.translate(
            offset: Offset(2, 5),
            child: Container(
              alignment: Alignment.center,
              width: 25.0,
              height: 25.0,
              decoration: new BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              child: Text(
                '$ayahnumber',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'QuraanFont',
                  color: kTextColor,
                ),
              ),
            ),
          ),
          Text(
            ayah,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 23,
              fontFamily: 'QuraanFont',
              color: kTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
