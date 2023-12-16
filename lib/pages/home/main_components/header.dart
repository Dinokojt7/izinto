import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../models/user.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/miscellaneous/app_icon.dart';
import '../../options/profile_settings.dart';
import '../wrapper.dart';
import 'header_details.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.user,
    required String name,
    required String street,
    required String address,
    required String area,
  })  : _name = name,
        _street = street,
        _address = address,
        _area = area;

  final UserModel? user;
  final String _name;
  final String _street;
  final String _address;
  final String _area;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (user != null) {
          Get.to(
              () => ProfileSettings(
                    isPhoneAuth: false,
                  ),
              transition: Transition.fade,
              duration: Duration(seconds: 1));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(seconds: 4),
              elevation: 0,
              backgroundColor: Color(0xff9A9484).withOpacity(0.9),
              behavior: SnackBarBehavior.floating,
              content: Container(
                margin: EdgeInsets.zero,
                child: const Text('Please login to proceed'),
              ),
              action: SnackBarAction(
                label: 'LOGIN',
                disabledTextColor: Colors.white,
                textColor: Colors.white,
                onPressed: () {
                  Get.to(() => const Wrapper(),
                      transition: Transition.fade,
                      duration: Duration(seconds: 1));
                },
              ),
            ),
          );
        }
      },
      child: Container(
        width: Dimensions.screenWidth / 1.08,
        margin: EdgeInsets.symmetric(
          horizontal: Dimensions.screenWidth / 70,
          vertical: Dimensions.screenWidth / 70,
        ),
        padding: EdgeInsets.only(
            top: Dimensions.height10,
            bottom: Dimensions.height10 / 2,
            left: Dimensions.screenWidth / 40,
            right: Dimensions.screenWidth / 80),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2.5,
              offset: Offset(1, 2),
            ),
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2.5,
              offset: Offset(0, -1),
            ),
          ],
          border: Border.all(
            width: 2,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Wrap(
          children: [
            GestureDetector(
                onTap: () {
                  if (user != null) {
                    Get.to(
                        () => ProfileSettings(
                              isPhoneAuth: false,
                            ),
                        transition: Transition.fade,
                        duration: Duration(seconds: 1));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 4),
                        elevation: 0,
                        backgroundColor: Color(0xff9A9484).withOpacity(0.9),
                        behavior: SnackBarBehavior.floating,
                        content: Container(
                          margin: EdgeInsets.zero,
                          child: const Text('Please login to proceed'),
                        ),
                        action: SnackBarAction(
                          label: 'LOGIN',
                          disabledTextColor: Colors.white,
                          textColor: Colors.white,
                          onPressed: () {
                            Get.to(() => const Wrapper(),
                                transition: Transition.fade,
                                duration: Duration(seconds: 1));
                          },
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius:
                        BorderRadius.circular(Dimensions.height10 * 5),
                    border: Border.all(
                      width: 1,
                      color: Colors.black12,
                    ),
                  ),
                  child: AppIcon(
                      icon: (MdiIcons.tuneVariant),
                      backgroundColor: Colors.transparent,
                      iconSize: Dimensions.height20,
                      size: Dimensions.height10 / 2 + Dimensions.height30,
                      iconColor: Colors.black87),
                )),
            SizedBox(
              width: Dimensions.screenWidth / 50,
            ),
            Wrap(
              children: [
                GestureDetector(
                  onTap: () {
                    if (user != null) {
                      Get.to(
                          () => ProfileSettings(
                                isPhoneAuth: false,
                              ),
                          transition: Transition.fade,
                          duration: Duration(seconds: 1));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 4),
                          elevation: 0,
                          backgroundColor: Color(0xff9A9484).withOpacity(0.9),
                          behavior: SnackBarBehavior.floating,
                          content: Container(
                            margin: EdgeInsets.zero,
                            child: const Text('Please login to proceed'),
                          ),
                          action: SnackBarAction(
                            label: 'LOGIN',
                            disabledTextColor: Colors.white,
                            textColor: Colors.white,
                            onPressed: () {
                              Get.to(() => const Wrapper(),
                                  transition: Transition.fade,
                                  duration: Duration(seconds: 1));
                            },
                          ),
                        ),
                      );
                    }
                  },
                  child: HeaderDetails(
                      name: _name,
                      street: _street,
                      address: _address,
                      area: _area),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
