import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import '../../controllers/car_specialty_controller.dart';
import '../../controllers/car_wash_support_questions_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/laundry_specialty_controller.dart';
import '../../controllers/laundry_support_questions_controller.dart';
import '../../controllers/popular_specialty_controller.dart';
import '../../controllers/recommended_specialty_controller.dart';
import '../../controllers/subscription_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/user.dart';
import '../../services/map_function.dart';
import '../../services/phone_auth_methods.dart';
import '../auth/access.dart';
import 'home_page.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  Future<void> _loadResources() async {
    await Get.find<RecommendedSpecialtyController>()
        .getRecommendedSpecialtyList();
    await Get.find<UserController>().getUserInfo();
    await Get.find<CartController>().getCartHistoryList();
    await Get.find<PopularSpecialtyController>().getPopularSpecialtyList();
    await Get.find<LaundrySpecialtyController>().getLaundrySpecialtyList();
    await Get.find<CarSpecialtyController>().getCarSpecialtyList();
    await Get.find<SubscriptionController>().getSubscriptionList();
    await Get.find<LaundrySupportQuestionsController>()
        .getLaundrySupportQuestionsList();
    await Get.find<CarWashSupportQuestionsController>()
        .getCarWashSupportQuestionsList();
    await Get.find<PhoneAuthMethods>();
    //FlutterNativeSplash.remove();
  }

  @override
  void initState() {
    super.initState();
    // initializeUser();
    _loadResources();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    final cartItems = Get.find<CartController>().getItems;
    //return either home or authenticate widget
    if (user == null) {
      return Access();
    } else {
      return HomePage();
    }
  }
}
