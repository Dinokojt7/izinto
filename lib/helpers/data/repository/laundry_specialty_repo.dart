import 'package:get/get.dart';

import '../../../utils/app_constants.dart';
import '../api/api_client.dart';


class LaundrySpecialtyRepo extends GetxService {
  final ApiClient apiClient;
  LaundrySpecialtyRepo({required this.apiClient});

  Future<Response> getLaundrySpecialtyList() async {
    return await apiClient.getData(AppConstants.LAUNDRY_SPECIALTY_URI);
  }
}
