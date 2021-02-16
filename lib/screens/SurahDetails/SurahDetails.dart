import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tafseer_app/constants.dart';
import 'package:tafseer_app/screens/SurahTafseer/SurahTafseer.dart';
import 'package:tafseer_app/services/TafseerAPI.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';

// ignore: camel_case_types
class Surah_details extends StatefulWidget {
  const Surah_details({
    Key key,
    // ignore: non_constant_identifier_names
    this.surah_name,
    // ignore: non_constant_identifier_names
    this.surah_num,
    // ignore: non_constant_identifier_names
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
  bool _loading = false;

  void loadAyahs() async {
    Tafseer li = Tafseer(url: '${widget.surah_num}');
    await li.getAyah();
    for (var j = 0; j <= (li.ayahs["data"]["ayahs"].length) - 1; j++) {
      responses.add(li.ayahs["data"]["ayahs"][j]["text"]);
    }
    setState(() {
      ayah = responses;
      _loading = true;
    });
  }

  List<InlineSpan> ayahTransform(List ayahs) {
    var children = <InlineSpan>[];
    for (var i = 0; i < ayahs.length; i++) {
      children.add(
        TextSpan(
          recognizer: TapGestureRecognizer()
            ..onTap = () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PageView.builder(
                        controller: PageController(initialPage: i),
                        reverse: true,
                        itemBuilder: (BuildContext context, int index) {
                          return SurahTafseer(
                              idsurah: widget.surah_num,
                              idayah: index + 1,
                              ayah: ayahs[index]);
                        },
                        itemCount: ayahs == null ? 0 : ayahs.length,
                      ),
                    ),
                  )
                },
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
    print('saliti');
    return children;
  }

  @override
  void initState() {
    loadAyahs();
    super.initState();
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
            child: Column(
              children: [
                SizedBox(
                  height: widget.height * 0.08,
                ),
                Center(
                    child: Text(
                  'سورة ${widget.surah_name}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 34, fontFamily: 'Tajawal', color: kTextColor),
                )),
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
                        child: _loading == false
                            ? _buildAnimated(width, height)
                            : RichText(
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

_buildAnimated(width_of_screen, height_of_screen) {
  return Container(
    width: width_of_screen,
    height: height_of_screen,
    child: PlaceholderLines(
      align: TextAlign.center,
      count: 50,
      animate: true,
      color: kPrimaryColor,
    ),
  );
}
