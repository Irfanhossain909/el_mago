import 'package:el_mago/routes/app_routes.dart';
import 'package:el_mago/services/repository/auth_repository.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateYourPasswordController extends GetxController {
  //All Repositories
  AuthRepository authRepository = AuthRepository.instance;

  //TextEditingController
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  //loading indicator
  RxBool isLoading = false.obs;

  //arguments
  late String resetToken;

  //validation
  bool validate() {
    if (newPassController.text.isEmpty) {
      Get.snackbar("Error", "Please enter your old password");
      return false;
    } else if (confirmPassController.text.isEmpty) {
      Get.snackbar("Error", "Please enter your confirm password");
      return false;
    } else if (newPassController.text != confirmPassController.text) {
      Get.snackbar("Error", "Password does not match");
      return false;
    }
    return true;
  }

  // Reset password function
  Future<void> forgetPassEmailSend() async {
    try {
      if (!validate()) return;
      isLoading.value = true;
      var response = await authRepository.resetPassword(
        newPassword: newPassController.text,
        confirmPassword: confirmPassController.text,
        resetToken: resetToken,
      );

      if (response) {
        Get.snackbar("Success", "Reset password successfull");
        Get.offAllNamed(AppRoutes.instance.signinScreen);
      } else {
        isLoading.value = false;
        Get.snackbar("Error", "Password change failed");
      }
    } catch (e) {
      AppPrint.appError(e, title: "reset Password");
    } finally {
      isLoading.value = false;
    }
  }

  ///dispose
  void controllerDispose() {
    newPassController.dispose();
    confirmPassController.dispose();
  }

  //controller initialize
  void controllerInisialize() {
    newPassController = TextEditingController();
    confirmPassController = TextEditingController();
  }

  @override
  void onInit() {
    resetToken = Get.arguments;
    controllerInisialize();
    super.onInit();
  }

  @override
  void onClose() {
    controllerDispose();
    super.onClose();
  }
}
