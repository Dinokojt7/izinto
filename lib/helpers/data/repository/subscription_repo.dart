import 'package:get/get.dart';
import 'package:izinto/helpers/data/api/api_client.dart';
import 'package:izinto/utils/app_constants.dart';

class SubscriptionRepo extends GetxService {
  final ApiClient apiClient;
  SubscriptionRepo({required this.apiClient});

  Future<Response> getSubscriptionList() async {
    return await apiClient.getData(AppConstants.SUBSCRIPTION_URI);
  }
}
