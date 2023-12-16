import 'package:flutter/material.dart';
import 'package:izinto/utils/dimensions.dart';

class IntegerText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double? height;
  TextOverflow overFlow;
  FontWeight? fontWeight;
  int? maxLines;
  TextAlign? align;
  IntegerText(
      {Key? key,
      this.color = const Color(0xFF707070),
      required this.text,
      this.fontWeight,
      this.height,
      this.align,
      this.maxLines,
      this.overFlow = TextOverflow.clip,
      this.size = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: overFlow,
      style: TextStyle(
        height: height,
        fontFamily: 'Poppins',
        color: color,
        fontSize: size == 0 ? Dimensions.font20 : size,
        fontWeight: fontWeight,
      ),
    );
  }
}
