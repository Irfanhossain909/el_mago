import 'package:el_mago/screens/auth/create_your_password_screen/controller/create_your_password_controller.dart';
import 'package:el_mago/screens/auth/forget_pass_screen/controller/forget_password_controller.dart';
import 'package:el_mago/screens/auth/forgetpass_verify_otp_screen/controller/forgetpass_verify_otp_controller.dart';
import 'package:el_mago/screens/auth/sign_in_screen/controller/signin_controller.dart';
import 'package:el_mago/screens/auth/sign_up_screen/controller/signup_controller.dart';
import 'package:el_mago/screens/auth/splash_screen/controller/splash_controller.dart';
import 'package:el_mago/screens/auth/verify_otp_screen/controller/verify_otp_controller.dart';
import 'package:el_mago/screens/chnage_pass_screen/controller/chnage_password_controller.dart';
import 'package:el_mago/screens/chnage_profile_info/controller/chnage_profile_controller.dart';
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
    Get.lazyPut(() => VerifyOtpController());
    Get.lazyPut(() => ForgetPasswordController());
    Get.lazyPut(() => ForgetPassVerifyOtpController());
    Get.lazyPut(() => CreateYourPasswordController());
    ///////////app
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => ChnagePasswordController());
    Get.lazyPut(() => ChnageProfileController());
    /////Navigations
    Get.lazyPut(() => SalesNavigationScreenController());
    Get.lazyPut(() => RetailerNavigationScreenController());
  }
}
