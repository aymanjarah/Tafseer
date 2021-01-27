import 'package:flutter/material.dart';
import 'package:tafseer_app/constants.dart';
import 'package:tafseer_app/screens/SurahDetails/SurahDetails.dart';

class SurahTab extends StatefulWidget {
  const SurahTab({
    Key key,
    this.surah_name,
    this.number_of_Ayah,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  final String surah_name;
  final int number_of_Ayah;
  final double width;
  final double height;

  @override
  _SurahTabState createState() => _SurahTabState();
}

class _SurahTabState extends State<SurahTab> {
  Future<void> Test() async {
    await (print('rr'));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        width: widget.width * 0.9,
        height: widget.height * 0.1,
        decoration: BoxDecoration(
          color: Color.fromRGBO(29, 28, 28, 1),
          borderRadius: BorderRadius.circular(29),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 1).withOpacity(0.35),
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Surah_details(
                    width: widget.width,
                    height: widget.height,
                    surah_name: widget.surah_name,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: kDefaultPadding + 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'عدد الايات',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Tajawal',
                              color: kTextColor),
                        ),
                        Text(
                          ' ${widget.number_of_Ayah}',
                          style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'Tajawal',
                              color: kTextColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: widget.width * 0.35,
                    height: widget.height * 0.055,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(29),
                    ),
                    child: Center(
                        child: Text(
                      ' سورة ${widget.surah_name}',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Tajawal',
                          color: kTextColor),
                      textAlign: TextAlign.center,
                    )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
