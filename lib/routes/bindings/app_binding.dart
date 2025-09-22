import 'package:el_mago/screens/auth/sign_up_screen/controller/signup_controller.dart';
import 'package:get/get.dart';
class AppBinding extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => SignUpController());
  }
}
