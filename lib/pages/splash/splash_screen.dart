import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/laundry_specialty_controller.dart';
import '../../controllers/popular_specialty_controller.dart';
import '../../controllers/recommended_specialty_controller.dart';
import '../../controllers/user_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/dimensions.dart';
import '../auth/sign_in.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  late final FirebaseAuth _user;
  late final FirebaseAuth _auth;

  Future<void> _loadResources() async {
    await Get.find<RecommendedSpecialtyController>()
        .getRecommendedSpecialtyList();
    await Get.find<UserController>().getUserInfo();
    await Get.find<CartController>().getCartHistoryList();
    await Get.find<PopularSpecialtyController>().getPopularSpecialtyList();
    await Get.find<LaundrySpecialtyController>().getLaundrySpecialtyList();
  }

  // Future initializeUser() async {
  //   final User? firebaseUser = await FirebaseAuth.instance.currentUser;
  //   await firebaseUser?.reload();
  //   _user = await _auth.currentUser as FirebaseAuth;
  //   // get User authentication status here
  // }

  @override
  void initState() {
    super.initState();
    // initializeUser();
    _loadResources();

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(const Duration(seconds: 3),
        () => Get.toNamed(RouteHelper.getInitial()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffB09B78),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='4' height='4' viewBox='0 0 4 4'%3E%3Cpath fill='%23344154' fill-opacity='0.53' d='M1 3h1v1H1V3zm2-2h1v1H3V1z'%3E%3C/path%3E%3C/svg%3E",
                scale: Dimensions.screenHeight),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 50),
            ),
            Center(
              child: Image.asset(
                'assets/image/asset.png',
                width: Dimensions.splashImg,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Transform.scale(
              scale: 0.5,
              child: CircularProgressIndicator(
                color: const Color(0xff8d7053),
              ),
            )
          ],
        ),
      ),
    );
  }
}
