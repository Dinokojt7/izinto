import 'package:get/get.dart';
import '../../../utils/app_constants.dart';
import '../api/api_client.dart';

class SubscriptionRepo extends GetxService {
  final ApiClient apiClient;
  SubscriptionRepo({required this.apiClient});

  Future<Response> getSubscriptionList() async {
    return await apiClient.getData(AppConstants.SUBSCRIPTION_URI);
  }
}
