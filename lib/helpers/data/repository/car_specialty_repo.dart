import 'package:get/get.dart';

import '../../../utils/app_constants.dart';
import '../api/api_client.dart';


class CarSpecialtyRepo extends GetxService {
  final ApiClient apiClient;
  CarSpecialtyRepo({required this.apiClient});

  Future<Response> getCarSpecialtyList() async {
    return await apiClient.getData(AppConstants.CAR_SPECIALTY_URI);
  }
}
