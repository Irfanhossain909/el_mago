import 'package:get/get.dart';

class RetailerMySubscriptionController extends GetxController {
  // Observable for terms and conditions agreement
  RxBool isTermsAgreed = false.obs;

  // Method to toggle terms agreement
  void toggleTermsAgreement() {
    isTermsAgreed.value = !isTermsAgreed.value;
  }

  // Method to validate if terms are agreed before proceeding
  bool validateTermsAgreement() {
    if (!isTermsAgreed.value) {
      Get.snackbar(
        "Agreement Required",
        "Please agree to the terms & conditions to continue.",
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
      return false;
    }
    return true;
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize any data if needed
  }
}
