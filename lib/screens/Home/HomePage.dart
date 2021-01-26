import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tafseer_app/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tafseer_app/screens/Home/components/AnimatedSearchBar.dart';
import 'package:tafseer_app/screens/Home/components/SurahTab.dart';
import 'dart:convert';

class HomePage extends StatelessWidget {
  List data;
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
                      width: width,
                      height: height,
                    ),
                  ),
                  SizedBox(height: height * 0.04),
                  Flexible(
                    child: FutureBuilder(
                      future: DefaultAssetBundle.of(context)
                          .loadString('Assets/testfile.json'),
                      builder: (context, snapshot) {
                        // Decode the JSON
                        var newData = json.decode(snapshot.data.toString());
                        return ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return SurahTab(
                                surah_name: newData[index]['name'],
                                number_of_Ayah: newData[index]['total_verses'],
                                width: width,
                                height: height);
                          },
                          itemCount: newData == null ? 0 : newData.length,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
