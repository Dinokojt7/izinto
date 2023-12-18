import 'package:get/get.dart';
import '../../../utils/app_constants.dart';
import '../api/api_client.dart';

class LaundrySupportQuestionsRepo extends GetxService {
  final ApiClient apiClient;
  LaundrySupportQuestionsRepo({required this.apiClient});

  Future<Response> getLaundrySupportQuestionsList() async {
    return await apiClient.getData(AppConstants.LAUNDRY_SUPPORT_QUESTIONS);
  }
}
