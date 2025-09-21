

import 'package:get/get.dart';
import 'package:tinnierenee12/screen/auth/sign_up_screen/controller/signup_controller.dart';
import 'package:tinnierenee12/screen/splash_screen/controller/splash_controller.dart';

class AuthBinding extends Bindings {
  @override
  dependencies() {

    Get.lazyPut(() => SplashController());
    Get.lazyPut(() => SignUpController());
  }
}
