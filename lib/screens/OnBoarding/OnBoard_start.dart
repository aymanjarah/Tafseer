import 'package:flutter/material.dart';
import 'package:tafseer_app/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tafseer_app/screens/Home/HomePage.dart';

// ignore: camel_case_types
class OnBoard_start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: GestureDetector(
        onTap: () {
          print('ok ok');
        },
        child: Column(
          children: [
            SizedBox(height: height * 0.1),
            Text(
              'حول التطبيق',
              style: TextStyle(
                  fontFamily: 'Tajawal', color: kTextColor, fontSize: 34),
            ),
            SizedBox(height: 15),
            Text(
              'تطبيق لتفسير اَيات القراَن الكريم يشمل \n .تفسير الجلالين و الميسر و السعدي',
              textAlign: TextAlign.center,
              style: TextStyle(
                  height: 2,
                  fontFamily: 'Tajawal',
                  color: kTextColor,
                  fontSize: 16),
            ),
            SizedBox(height: 25),
            Center(child: SvgPicture.asset('Assets/Salat.svg')),
            SizedBox(height: height * 0.06),
            ButtonMain(
              textSize: 19,
              text: "ابدَأ",
              width: 92,
              height: 45,
              colortext: Colors.black,
              colorBorder: Colors.transparent,
              color: kPrimaryColor,
              page: HomePage(),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonMain extends StatelessWidget {
  const ButtonMain({
    Key key,
    this.width,
    this.height,
    this.color,
    this.colortext,
    this.text,
    this.colorBorder,
    this.textSize,
    this.page,
  }) : super(key: key);
  final String text;
  final Color colorBorder;
  final double width;
  final double textSize;
  final double height;
  final Color color;
  final Color colortext;
  final Widget page;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          ),
        );
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(36),
          border: Border.all(color: colorBorder),
        ),
        child: Center(
            child: Text("$text",
                style: TextStyle(
                    fontSize: textSize,
                    color: colortext,
                    fontFamily: 'Tajawal'))),
      ),
    );
  }
}
