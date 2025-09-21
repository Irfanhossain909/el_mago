import 'package:get/get.dart';

class SignUpController extends GetxController {
  // Observable variable for checkbox state
  var isChecked = false.obs;

  // Function to toggle the checkbox value
  void toggleCheckbox(bool value) {
    isChecked.value = value;
  }
}
