import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tafseer_app/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tafseer_app/screens/Home/components/AnimatedSearchBar.dart';
import 'package:tafseer_app/screens/Home/components/SurahTab.dart';
import 'dart:convert';
import 'dart:async';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic data;
  String _f = '';
  void getData() async {
    dynamic ayahsList = await rootBundle.loadString('Assets/testfile.json');
    ayahsList = json.decode(ayahsList.toString());
    setState(() {
      data = ayahsList;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void first(String btn) {
    setState(() {
      _f = btn;
      print(_f);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                children: [
                  SizedBox(height: height * 0.07),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'مرحبا',
                        style: TextStyle(
                            color: kTextColor,
                            fontSize: 34,
                            fontFamily: 'Tajawal'),
                      )),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AnimatedSearch(
                      event: first,
                      width: width,
                      height: height,
                    ),
                  ),
                  SizedBox(height: height * 0.04),
                  Flexible(
                      child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return SurahTab(
                          surah_number: index,
                          surah_name: data[index]['name'],
                          number_of_Ayahs: data[index]['total_verses'],
                          width: width,
                          height: height);
                    },
                    itemCount: data == null ? 0 : data.length,
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
