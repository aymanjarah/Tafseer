import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tafseer_app/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tafseer_app/screens/Home/components/AnimatedSearchBar.dart';
import 'package:tafseer_app/screens/Home/components/SurahTab.dart';
import 'dart:convert';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String messageTitle = "Empty";
  String notificationAlert = "alert";
  List _ayahs;

  List _filteredNames;
  void getData() async {
    dynamic ayahsList = await rootBundle.loadString('Assets/testfile.json');
    ayahsList = json.decode(ayahsList.toString());
    setState(() {
      _filteredNames = ayahsList;
      _ayahs = ayahsList;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void filter(String field) {
    List tempList = [];
    for (int i = 0; i < _ayahs.length; i++) {
      if (_ayahs[i]['name'].toLowerCase().contains(field.toLowerCase())) {
        tempList.add(_ayahs[i]);
      }
    }
    setState(() {
      _filteredNames = tempList;
      print(field);
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
                      alignment: Alignment.centerRight,
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
                      state: filter,
                      data: _ayahs,
                      width: width,
                      height: height,
                    ),
                  ),
                  SizedBox(height: height * 0.04),
                  Flexible(
                      child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return SurahTab(
                          surah_number: _filteredNames[index]['number'],
                          surah_name: _filteredNames[index]['name'],
                          number_of_Ayahs: _filteredNames[index]
                              ['total_verses'],
                          width: width,
                          height: height);
                    },
                    itemCount:
                        _filteredNames == null ? 0 : _filteredNames.length,
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
