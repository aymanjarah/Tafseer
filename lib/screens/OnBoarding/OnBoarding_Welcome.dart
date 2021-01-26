import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tafseer_app/constants.dart';
import 'package:tafseer_app/screens/OnBoarding/OnBoard_start.dart';

class OnBoardingWelcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: GestureDetector(
        onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) =>OnBoard_start()));},
        child: Column(
          children: [
            SizedBox(height: height*0.2,),
            Center(child: SvgPicture.asset('Assets/Tafseer.svg')),
            Flexible(child:Align(alignment:Alignment.bottomCenter,child: SvgPicture.asset('Assets/Groupi.svg'))),
          ],
        ),
      ),
    );
  }
}
