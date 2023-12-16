import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/texts/integers_and_doubles.dart';
import '../../home/home_page.dart';

class HomeButton extends StatefulWidget {
  const HomeButton({Key? key, required this.title, required this.activeScreen})
      : super(key: key);
  final String title;
  final int activeScreen;

  @override
  State<HomeButton> createState() => _HomeButtonState();
}

class _HomeButtonState extends State<HomeButton> {
  final List<String> activeScreen = ['Laundry', 'Car Wash', 'Subscriptions'];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height45 / 1.1,
      decoration: BoxDecoration(
        color: activeScreen[widget.activeScreen] == widget.title
            ? Colors.transparent
            : Colors.transparent,
        border: Border.all(
          width: 1.5,
          color: activeScreen[widget.activeScreen] == widget.title
              ? AppColors.fontColor.withOpacity(0.7)
              : Colors.grey.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(Dimensions.radius20 * 3),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Dimensions.width10 / 2, horizontal: Dimensions.width10),
        child: Center(
          //register
          child: IntegerText(
            text: widget.title,
            size: Dimensions.font16 / 1.2,
            fontWeight: FontWeight.w600,
            color: activeScreen[widget.activeScreen] == widget.title
                ? AppColors.fontColor
                : AppColors.fontColor.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
