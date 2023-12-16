import 'package:get/get.dart';
import 'package:izinto/controllers/auth_controller.dart';
import 'package:izinto/controllers/cart_controller.dart';
import 'package:izinto/controllers/laundry_specialty_controller.dart';
import 'package:izinto/controllers/laundry_support_questions_controller.dart';
import 'package:izinto/controllers/recommended_specialty_controller.dart';
import 'package:izinto/helpers/data/api/api_client.dart';
import 'package:izinto/helpers/data/repository/car-wash-support-questions-repo.dart';
import 'package:izinto/helpers/data/repository/cart_repo.dart';
import 'package:izinto/helpers/data/repository/laundry_specialty_repo.dart';
import 'package:izinto/helpers/data/repository/laundry_support_repo.dart';
import 'package:izinto/helpers/data/repository/recommended_specialty_repo.dart';
import 'package:izinto/helpers/data/repository/subscription_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/car_specialty_controller.dart';
import '../controllers/car_wash_support_questions_controller.dart';
import '../controllers/popular_specialty_controller.dart';
import '../controllers/subscriptions.dart';
import '../controllers/user_controller.dart';
import '../services/phone_auth_methods.dart';
import '../utils/app_constants.dart';
import 'data/repository/auth_repo.dart';
import 'data/repository/car_specialty_repo.dart';
import 'data/repository/popular_specialty_repo.dart';
import 'data/repository/user_repo.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  //This is our ApiClient
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));

  //This will get our repositories
  Get.lazyPut(() => PopularSpecialtyRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedSpecialtyRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(() => LaundrySpecialtyRepo(apiClient: Get.find()));
  Get.lazyPut(() => CarSpecialtyRepo(apiClient: Get.find()));
  Get.lazyPut(() => LaundrySpecialtyRepo(apiClient: Get.find()));
  Get.lazyPut(() => SubscriptionRepo(apiClient: Get.find()));
  Get.lazyPut(() => LaundrySupportQuestionsRepo(apiClient: Get.find()));
  Get.lazyPut(() => CarWashSupportQuestionsRepo(apiClient: Get.find()));

  //controllers
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() =>
      RecommendedSpecialtyController(recommendedSpecialtyRepo: Get.find()));
  Get.lazyPut(
      () => PopularSpecialtyController(popularSpecialtyRepo: Get.find()));
  Get.lazyPut(() => LaundrySpecialtyController(
      laundrySpecialtyRepo: Get.find(), cartRepo: Get.find()));
  Get.lazyPut(() => CarSpecialtyController(carSpecialtyRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => SubscriptionController(subscriptionRepo: Get.find()));
  Get.lazyPut(() => LaundrySupportQuestionsController(
      laundrySupportQuestionsRepo: Get.find()));
  Get.lazyPut(() => CarWashSupportQuestionsController(
      carWashSupportQuestionsRepo: Get.find()));
  Get.lazyPut(() => PhoneAuthMethods());
}
