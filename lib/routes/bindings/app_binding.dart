
import 'package:el_mago/screens/auth/sign_in_screen/controller/signin_controller.dart';
import 'package:el_mago/screens/auth/sign_up_screen/controller/signup_controller.dart';
import 'package:el_mago/screens/auth/splash_screen/controller/splash_controller.dart';
import 'package:el_mago/screens/profile_screen/controller/profile_controller.dart';
import 'package:el_mago/screens/retailer_navigation_screen/controller/retailer_navigation_screen_controller.dart';
import 'package:el_mago/screens/sales_navigation_screen/controller/sales_navigation_screen_controller.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => SplashController());
    ///////////auth
    Get.lazyPut(() => SignUpController());
    Get.lazyPut(() => SigninController());
    ///////////auth
    Get.lazyPut(() => ProfileController());
    /////Navigations
    Get.lazyPut(() => SalesNavigationScreenController());
    Get.lazyPut(() => RetailerNavigationScreenController());
  }
}
