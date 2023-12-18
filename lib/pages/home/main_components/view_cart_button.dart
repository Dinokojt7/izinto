import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../controllers/cart_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../cart/cart_page.dart';
import '../../cart/re_cart.dart';

class ViewCartFloating extends StatelessWidget {
  const ViewCartFloating({
    super.key,
    required this.storedTime,
    required this.carTime,
    required this.availableKilos,
    required this.totalWashes,
  });

  final DateTime? storedTime;
  final DateTime? carTime;
  final int? availableKilos;
  final int totalWashes;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      extendedPadding: EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      elevation: 0,
      splashColor: Colors.transparent,
      enableFeedback: false,
      onPressed: null,
      label: GetBuilder<CartController>(builder: (_cartController) {
        return Container(
          width: Dimensions.height20 * 8.5,
          height: Dimensions.height20 * 8.5,
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 0, top: 10.0, bottom: 8.0),
            child: GestureDetector(
              onTap: () {
                print('Look some date here $storedTime');
                Get.to(
                    // () => CartPage(
                    //       storedTime: storedTime,
                    //       carTime: carTime,
                    //       availableKilos: availableKilos,
                    //       remainingWashes: totalWashes.toString(),
                    //     ),
                    () => ReCart(),
                    duration: Duration(milliseconds: 500));
              },
              child: Center(
                child: Stack(
                  children: [
                    Positioned(
                      top: 17,
                      right: -60,
                      left: 0,
                      child: Center(
                        child: Container(
                          width: Dimensions.height20 * 4.3,
                          height: Dimensions.height20 * 4.5,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(1, 1),
                                blurRadius: 1,
                                color: Colors.black.withOpacity(0.2),
                              ),
                              BoxShadow(
                                offset: Offset(-1, -1),
                                blurRadius: 1,
                                color: Colors.black.withOpacity(0.2),
                              )
                            ],
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${Get.find<CartController>().totalItems.toString()}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      color: AppColors.fontColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'Checkout',
                                  style: TextStyle(
                                      fontSize: Dimensions.font16 / 1.4,
                                      fontFamily: 'Poppins',
                                      color: AppColors.fontColor,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: -60,
                      left: 0,
                      child: GestureDetector(
                        onTap: () {
                          Get.to(
                              () => CartPage(
                                    storedTime: storedTime,
                                    carTime: carTime,
                                    availableKilos: availableKilos,
                                    remainingWashes: totalWashes.toString(),
                                  ),
                              duration: Duration(milliseconds: 500));
                        },
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.height10 * 5),
                                color: const Color(0xff966C3B),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(2, 1),
                                      blurRadius: 1,
                                      color: const Color(0xff966C3B)
                                          .withOpacity(0.4))
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(
                                MdiIcons.pail,
                                color: Colors.white,
                                size: Dimensions.iconSize24 * 1.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
