import 'package:get/get.dart';
import '../../../utils/app_constants.dart';
import '../api/api_client.dart';

class RecommendedSpecialtyRepo extends GetxService {
  final ApiClient apiClient;
  RecommendedSpecialtyRepo({required this.apiClient});

  Future<Response> getRecommendedSpecialtyList() async {
    return await apiClient.getData(AppConstants.RECOMMENDED_SPECIALTY_URI);
  }
}
