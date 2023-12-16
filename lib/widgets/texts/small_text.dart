import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  int maxLines;
  double size;
  double height;
  TextOverflow overFlow;
  FontWeight? fontWeight;
  SmallText({
    Key? key,
    this.color = const Color(0xFFa9a29f),
    required this.text,
    this.maxLines = 100,
    this.overFlow = TextOverflow.clip,
    this.fontWeight = FontWeight.w400,
    this.size = 14.0,
    this.height = 1.8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overFlow,
      maxLines: maxLines,
      style: TextStyle(
        fontFamily: 'Hind',
        letterSpacing: 0.10,
        color: color,
        fontSize: size,
        height: height,
        fontWeight: fontWeight,
      ),
    );
  }
}
