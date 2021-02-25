import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:tafseer_app/constants.dart';
import 'package:tafseer_app/services/TafseerAPI.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';

class SurahTafseer extends StatefulWidget {
  const SurahTafseer({
    Key key,
    // ignore: non_constant_identifier_names
    this.idsurah,
    // ignore: non_constant_identifier_names
    this.idayah,
    this.ayah,
    // ignore: non_constant_identifier_names
  }) : super(key: key);
  final int idsurah;
  final int idayah;
  final String ayah;

  @override
  _SurahTafseerState createState() => _SurahTafseerState();
}

class _SurahTafseerState extends State<SurahTafseer> {
  int _body = 2;
  String tafseer1 = '';
  String tafseer2 = '';
  String tafseer3 = '';
  String _active = 'تفسير الجلالين';
  bool _loading = true;

  // ignore: missing_return
  Widget bodyFunction(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    switch (_body) {
      case 0:
        return SizedBox(
          height: height * 0.7,
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding + 5),
            child: Column(
              children: [
                Flexible(
                  child: ListView(
                    children: [
                      _loading == true
                          ? _buildAnimated(width)
                          : Text(
                              tafseer3 ?? "",
                              textAlign: TextAlign.justify,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  wordSpacing: 4,
                                  height: 1.5,
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Tajawal'),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
        break;
      case 1:
        return SizedBox(
          height: height * 0.7,
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding + 5),
            child: Column(
              children: [
                Flexible(
                  child: ListView(
                    children: [
                      _loading == true
                          ? _buildAnimated(width)
                          : Text(
                              tafseer1 ?? "",
                              textAlign: TextAlign.justify,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  wordSpacing: 4,
                                  height: 1.5,
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Tajawal'),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
        break;
      case 2:
        return SizedBox(
          height: height * 0.7,
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding + 5),
            child: Column(
              children: [
                Flexible(
                  child: ListView(
                    children: [
                      _loading == true
                          ? _buildAnimated(width)
                          : Text(
                              tafseer2 ?? "",
                              textAlign: TextAlign.justify,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  wordSpacing: 4,
                                  height: 1.5,
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Tajawal'),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
        break;
    }
  }

  void active(String btn) {
    setState(() {
      _active = btn;
    });
  }

  // ignore: non_constant_identifier_names
  void ChangeBody(int index) {
    setState(() {
      _body = index;
    });
  }

  @override
  void initState() {
    super.initState();
    loadTafseer();
  }

  void loadTafseer() async {
    Tafseer tafseerAyah2 = Tafseer(url: '2/${widget.idsurah}/${widget.idayah}');
    Tafseer tafseerAyah3 = Tafseer(url: '3/${widget.idsurah}/${widget.idayah}');
    Tafseer tafseerAyah1 = Tafseer(url: '1/${widget.idsurah}/${widget.idayah}');
    Future.wait([
      tafseerAyah2.getTafseer(),
      tafseerAyah3.getTafseer(),
      tafseerAyah1.getTafseer()
    ]).then((void v) {
      if (mounted) {
        setState(() {
          tafseer1 = tafseerAyah1.tafseer;
          tafseer2 = tafseerAyah2.tafseer;
          tafseer3 = tafseerAyah3.tafseer;
          _loading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 50,
                  right: kDefaultPadding + 5,
                  left: kDefaultPadding + 5),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'Assets/Arrow.svg',
                    width: 8,
                    height: 14,
                  ),
                  Text(
                    'الرجوع ',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Tajawal',
                        color: kPrimaryColor,
                        letterSpacing: 1.5),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: kDefaultPadding, horizontal: kDefaultPadding + 5),
            child: Align(
                alignment: Alignment.topRight,
                child: AutoSizeText(
                  '${widget.ayah}',
                  style: TextStyle(
                      fontSize: 18, fontFamily: 'Cairo', color: kTextColor),
                  maxLines: 1,
                  textAlign: TextAlign.right,
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: kDefaultPadding, horizontal: kDefaultPadding + 5),
            child: Container(
              height: height * 0.06,
              width: width,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TagWall(
                      event: ChangeBody,
                      action: active,
                      index: 0,
                      active: _active == 'تفسير السعدي' ? true : false,
                      text: "تفسير السعدي",
                      height: 25,
                      textSize: 15,
                      colortext: Colors.black,
                      color: kPrimaryColor,
                    ),
                    //SizedBox(width: width*0.1,),
                    TagWall(
                      event: ChangeBody,
                      action: active,
                      index: 1,
                      active: _active == 'التفسير الميسر' ? true : false,
                      text: "التفسير الميسر",
                      height: 25,
                      textSize: 15,
                      colortext: Colors.black,
                      color: kPrimaryColor,
                    ),
                    //SizedBox(width: width*0.05,),
                    TagWall(
                      event: ChangeBody,
                      action: active,
                      index: 2,
                      active: _active == 'تفسير الجلالين' ? true : false,
                      text: "تفسير الجلالين",
                      height: 25,
                      textSize: 15,
                      colortext: Colors.black,
                      color: kPrimaryColor,
                    ),
                  ]),
            ),
          ),
          bodyFunction(context),
        ],
      ),
    );
  }
}

class TagWall extends StatefulWidget {
  const TagWall(
      {Key key,
      this.width,
      this.height,
      this.color,
      this.action,
      this.active,
      this.event,
      this.colortext,
      this.text,
      this.index,
      this.textSize})
      : super(key: key);
  final String text;
  final ValueChanged<String> action;
  final ValueChanged<int> event;
  final bool active;
  final double width;
  final int index;
  final double textSize;
  final double height;
  final Color color;
  final Color colortext;

  @override
  _TagWallState createState() => _TagWallState();
}

class _TagWallState extends State<TagWall> {
  void handleTap() {
    setState(() {
      widget.action(widget.text);
      widget.event(widget.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: handleTap,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(29),
              color: widget.active ? widget.color : Colors.transparent,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                  child: Text("${widget.text}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: widget.textSize,
                          color:
                              widget.active ? widget.colortext : Colors.white,
                          fontFamily: 'Tajawal'))),
            ),
          ),
        ));
  }
}

_buildAnimated(widthOfScreen) {
  return Container(
    width: widthOfScreen,
    child: PlaceholderLines(
      align: TextAlign.right,
      count: 5,
      animate: true,
      color: kPrimaryColor,
    ),
  );
}
