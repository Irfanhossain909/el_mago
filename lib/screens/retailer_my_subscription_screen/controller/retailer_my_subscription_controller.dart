import 'package:el_mago/models/sub_model/sub_model.dart';
import 'package:el_mago/services/repository/subscription_repository.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:get/get.dart';

class RetailerMySubscriptionController extends GetxController {
  // Observable for terms and conditions agreement
  RxBool isTermsAgreed = false.obs;
  List<SubModelData> subModelData = [];
  //repository
  SubscriptionRepository subscriptionRepository =
      SubscriptionRepository.instance;

  // Method to toggle terms agreement
  void toggleTermsAgreement() {
    isTermsAgreed.value = !isTermsAgreed.value;
  }

  //function
  Future<void> fetchSubData() async {
    try {
      var response = await subscriptionRepository.getSubModels();
      if (response.isNotEmpty) {
        subModelData = response;
      } else {
        AppPrint.appError("Response is empty");
      }
    } catch (e) {
      AppPrint.appError(e, title: "fetchSubData");
    }
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
    fetchSubData();
    super.onInit();
    
  }
}
