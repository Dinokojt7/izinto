import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izinto/controllers/recommended_specialty_controller.dart';
import 'package:izinto/widgets/texts/small_text.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../texts/integers_and_doubles.dart';

class AppColumn extends StatelessWidget {
  // final String text;

  const AppColumn({
    Key? key,

    // required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Brand and turnaround time
        GetBuilder<RecommendedSpecialtyController>(
            builder: (recommendedSpecialties) {
          return recommendedSpecialties.isLoaded
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        // BigText(
                        //   text: text,
                        //   size: Dimensions.font16 * 1.2,
                        //   weight: FontWeight.w500,
                        //   color: AppColors.mainColor,
                        // ),

                        Row(
                          children: [
                            // SizedBox(
                            //   width: 8,
                            // ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // const Image(
                                //   image: AssetImage('assets/image/court.png'),
                                //   width: 100,
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.only(left: 3.0),
                                //   child: SmallText(
                                //     text: 'Waterfall Corner',
                                //     maxLines: 1,
                                //     color: AppColors.mainColor,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      width: Dimensions.height45 * 1.6,
                      height: Dimensions.height45 * 1.2,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
                        gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color(0xff966C3B),
                            Color(0xffA0937D),
                          ],
                        ),

                        // color: AppColors.titleColor)
                      ),
                      child: Column(
                        children: [
                          IntegerText(
                            text: 'ETA',
                            size: 13.0,
                            maxLines: 1,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          IntegerText(
                            text: '24 - 48hrs',
                            size: 10.0,
                            maxLines: 1,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    )
                  ],
                )
              : Container();
        })
      ],
    );
  }
}
