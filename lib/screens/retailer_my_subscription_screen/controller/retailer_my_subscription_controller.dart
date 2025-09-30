import 'package:el_mago/models/sub_model/sub_model.dart';
import 'package:el_mago/screens/retailer_select_extrabox_screen/controller/retailer_select_extrabox_controller.dart';
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

  RetailerSelectExtraboxController retailerSelectExtraboxController =
      Get.find<RetailerSelectExtraboxController>();

  // Rx variables
  RxBool status = false.obs;
  RxString message = "".obs;

  void checkEditBoxStatus() {
    DateTime now = DateTime.now();
    int day = now.day;

    if (day >= 1 && day <= 25) {
      status.value = true;
      message.value = "You can edit box";
    } else {
      int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
      int daysLeft = daysInMonth - day + 1; // +1 for next month start
      status.value = false;
      message.value =
          "Next month starts in $daysLeft day${daysLeft > 1 ? 's' : ''}";
    }
  }

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
    checkEditBoxStatus();
    fetchSubData();
    super.onInit();
  }
}
