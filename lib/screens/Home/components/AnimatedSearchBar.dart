import 'package:flutter/material.dart';



class AnimatedSearch extends StatefulWidget {
  const AnimatedSearch({
    Key key,
    @required this.width,
    @required this.height,
  }) : super(key: key);
  final double width;
  final double height;
  @override
  _AnimatedSearchState createState() => _AnimatedSearchState();
}

class _AnimatedSearchState extends State<AnimatedSearch > {

  @override
  bool _folded=true;
  Widget build(BuildContext context) {
    return AnimatedContainer(
          duration: Duration(milliseconds: 400),
          width: _folded? 56:widget.width,
          height: widget.height*0.07,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Colors.black,
              boxShadow: kElevationToShadow[6]
          ),
          child: Row(
            children: [
              Container(
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(_folded ? 32 : 0),
                      topRight: Radius.circular(32),
                      bottomLeft: Radius.circular(_folded ? 32 : 0),
                      bottomRight: Radius.circular(32),
                    ),
                    child: Icon(
                      _folded ? Icons.search : Icons.close,
                      color: Colors.white,
                    ),
                    onTap: () {
                      setState(() {
                        _folded = !_folded;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 16,right: 16),
                  child: !_folded
                      ? TextFormField(
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: 'بحت',
                        hintStyle: TextStyle(color: Colors.white,fontFamily: 'Tajawal'),
                        border: InputBorder.none),
                  ) : null,
                ),
              ),
            ],
          ),
    );
  }
}