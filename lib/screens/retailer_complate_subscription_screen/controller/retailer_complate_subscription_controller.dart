import 'package:el_mago/models/sub_model/sub_model.dart';
import 'package:el_mago/services/repository/subscription_repository.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RetailerComplateSubscriptionController extends GetxController {
  //textController
  TextEditingController nameController = TextEditingController();
  TextEditingController cardController = TextEditingController();
  TextEditingController expiryController = TextEditingController();
  TextEditingController cvcController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  //Repository
  SubscriptionRepository subscriptionRepository =
      SubscriptionRepository.instance;

  //variables
  var submodelvalue = SubModelData();
  //Loading state
  RxBool loading = false.obs;

  Future<void> updateCard() async {
    try {
      bool isValid = isValidation();
      if (!isValid) return;
      loading.value = true;
      var response = await subscriptionRepository.updateCardInfo(
        cardHolderName: nameController.text,
        cardNumber: cardController.text,
        cvv: cvcController.text,
        exclusiveProducts: submodelvalue.exclusiveProducts,
        expiryDate: expiryController.text,
        freeShipping: submodelvalue.freeShipping,
        limitedReleases: submodelvalue.limitedReleases,
        noCreditCardFee: submodelvalue.noCreditCardFee,
        subscription: submodelvalue.subscription,
        termsAndConditions:
            "By subscribing, you agree to our terms and conditions...",
        termsAndConditionsAccepted: submodelvalue.termsAndConditionsAccepted,
        tier: "$value ${submodelvalue.tier}",
        zipCode: zipController.text,
      );
      if (response) {
        Get.close(1);
        Get.snackbar("Success", "Card Updated Successfully");
        loading.value = false;
        // G
      } else {
        AppPrint.appError("updateCard is False");
        loading.value = false;
      }
    } catch (e) {
      AppPrint.appError(e, title: "updateCard");
    } finally {
      loading.value = false;
    }
  }

  //validation
  bool isValidation() {
    if (nameController.text.isEmpty) {
      Get.snackbar("Field", "Name cannot be empty");
      return false;
    } else if (cardController.text.isEmpty) {
      Get.snackbar("Field", "Card cannot be empty");
      return false;
    } else if (expiryController.text.isEmpty) {
      Get.snackbar("Field", "Expiry cannot be empty");
      return false;
    } else if (cvcController.text.isEmpty) {
      Get.snackbar("Field", "CVC cannot be empty");
    } else if (zipController.text.isEmpty) {
      Get.snackbar("Field", "Zip cannot be empty");
    }
    return true;
  }

  void disposeController() {
    nameController.dispose();
    cardController.dispose();
    expiryController.dispose();
    cvcController.dispose();
    zipController.dispose();
  }

  void controllerInisialiezed() {
    nameController = TextEditingController();
    cardController = TextEditingController();
    expiryController = TextEditingController();
    cvcController = TextEditingController();
    zipController = TextEditingController();
  }

  String? value;

  void valueRecived() {
    submodelvalue = Get.arguments["arg1"];
    value = Get.arguments["arg2"] ?? "";
    // final subModel = Get.arguments;
    // if (subModel != null && subModel is SubModelData) {
    //   submodelvalue = subModel;
    //   update();
    // }
  }

  @override
  void onInit() {
    valueRecived();
    controllerInisialiezed();
    super.onInit();
  }

  @override
  void onClose() {
    disposeController();
    super.onClose();
  }
}
