import 'package:get/get.dart';
import '../../../utils/app_constants.dart';
import '../api/api_client.dart';

class PopularSpecialtyRepo extends GetxService {
  final ApiClient apiClient;
  PopularSpecialtyRepo({required this.apiClient});

  Future<Response> getPopularSpecialtyList() async {
    return await apiClient.getData(AppConstants.POPULAR_SPECIALTY_URI);
  }
}
