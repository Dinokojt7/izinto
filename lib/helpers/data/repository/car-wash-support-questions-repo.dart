import 'package:get/get.dart';

import '../../../utils/app_constants.dart';
import '../api/api_client.dart';


class CarWashSupportQuestionsRepo extends GetxService {
  final ApiClient apiClient;
  CarWashSupportQuestionsRepo({required this.apiClient});

  Future<Response> getCarWashSupportQuestionsList() async {
    return await apiClient.getData(AppConstants.CAR_WASH_SUPPORT_QUESTIONS);
  }
}
