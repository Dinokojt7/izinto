import 'package:get/get.dart';
import '../helpers/data/repository/subscription_repo.dart';
import '../models/cart_model.dart';
import '../models/popular_specialty_model.dart';
import 'cart_controller.dart';
import '../helpers/data/repository/cart_repo.dart';

class SubscriptionController extends GetxController {
  final SubscriptionRepo subscriptionRepo;
  SubscriptionController({required this.subscriptionRepo});
  List<dynamic> _subscriptionList = [];
  List<dynamic> get subscriptionList => _subscriptionList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getSubscriptionList() async {
    Response response = await subscriptionRepo.getSubscriptionList();
    if (response.statusCode == 200) {
      _subscriptionList = [];
      _subscriptionList.addAll(Specialty.fromJson(response.body).specialties);
      _isLoaded = true;
      update();
    } else {
      print('subscription is ${response.statusCode}');
    }
  }
}
