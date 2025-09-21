import 'package:get/get.dart';
import 'package:tinnierenee12/screen/app_navigation_for_client_screen%20copy/controller/navigation_screen_for_client_controller.dart';
import 'package:tinnierenee12/screen/app_navigation_screen/controller/navigation_screen_controller.dart';
import 'package:tinnierenee12/screen/auth/personal_info_screen/controller/personal_info_controller.dart';
import 'package:tinnierenee12/screen/auth/client_business_info_screen/controller/client_business_info_controller.dart';
import 'package:tinnierenee12/screen/client_shift_screen/controller/client_shift_controller.dart';

class AppBinding extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => NavigationScreenController());
    Get.lazyPut(() => AppNavigationForClientController());
    Get.lazyPut(() => PersonalInfoController());
    Get.lazyPut(() => ClientBusinessInfoController());
    Get.lazyPut(() => ClientShiftController());
  }
}
