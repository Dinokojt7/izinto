import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:izinto/utils/dimensions.dart';
import 'package:izinto/widgets/miscellaneous/app_circle_button.dart';
import 'package:izinto/widgets/texts/small_text.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FirstOnboardingScreen extends StatelessWidget {
  const FirstOnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Dimensions.screenWidth * 0.16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                MdiIcons.washingMachine,
                size: 65,
                color: Colors.black45,
              ),
              SizedBox(
                height: Dimensions.width20,
              ),
              SmallText(
                  text:
                      'We\'re about to take care of your laundry demands like never before, let\'s connect you with the best services in your area'),
              SizedBox(
                height: Dimensions.width20,
              ),
              AppCircleButton(
                  onTap: () {},
                  child: Icon(
                    MdiIcons.arrowRight,
                    size: 35,
                    color: Colors.black38,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
