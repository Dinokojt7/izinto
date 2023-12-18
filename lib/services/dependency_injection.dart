import 'package:get/get.dart';

import '../controllers/network_controller.dart';

class NetworkInjection {
  static void init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}
