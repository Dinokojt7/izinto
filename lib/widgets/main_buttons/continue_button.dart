import 'package:flutter/material.dart';

import '../../utils/dimensions.dart';
import '../texts/big_text.dart';
import '../texts/integers_and_doubles.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({
    Key? key,
    this.isLoading,
    required this.cto,
  }) : super(key: key);

  final bool? isLoading;
  final String cto;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.screenHeight / 14,
      width: Dimensions.screenWidth / 2.6,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xffCFC5A5),
            Color(0xff9A9483),
          ],
        ),

        borderRadius: BorderRadius.all(
          Radius.circular(Dimensions.radius20 * 3),
        ),
        // color: const Color(0xff8d7053),
      ),
      child: isLoading!
          ? Transform.scale(
              scale: 0.5,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 6,
                  color: Colors.white,
                ),
              ),
            )
          : Center(
              child: IntegerText(
                text: cto,
                size: Dimensions.font16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
    );
  }
}
