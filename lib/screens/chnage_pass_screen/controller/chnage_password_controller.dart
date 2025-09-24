import 'package:el_mago/services/repository/auth_repository.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChnagePasswordController extends GetxController {
  //All Repositories
  AuthRepository authRepository = AuthRepository.instance;

  //TextEditingController
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  //loading indicator
  RxBool isLoading = false.obs;

  //validation
  bool validate() {
    if (oldPasswordController.text.isEmpty) {
      Get.snackbar("Error", "Please enter your old password");
      return false;
    } else if (newPasswordController.text.isEmpty) {
      Get.snackbar("Error", "Please enter your new password");
      return false;
    } else if (confirmPasswordController.text.isEmpty) {
      Get.snackbar("Error", "Please confirm your new password");
      return false;
    } else if (newPasswordController.text != confirmPasswordController.text) {
      return false;
    }
    return true;
  }

  // change password function
  Future<void> changePassword() async {
    try {
      if (!validate()) return;
      isLoading.value = true;
      var response = await authRepository.changePassword(
        currentPassword: oldPasswordController.text,
        newPassword: newPasswordController.text,
        confirmPassword: confirmPasswordController.text,
      );

      if (response) {
        Get.snackbar("Success", "Password changed successfully");
        controllerClear();
        Get.close(1);
      } else {
        isLoading.value = false;
        Get.snackbar("Error", "Password change failed");
      }
    } catch (e) {
      AppPrint.appError(e, title: "changePassword");
    } finally {
      isLoading.value = false;
    }
  }

  ///dispose
  void controllerDispose() {
    oldPasswordController.dispose();

    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }

  //controller initialize
  void controllerInisialize() {
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  //controller Clear
  void controllerClear() {
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }

  @override
  void onInit() {
    controllerInisialize();
    super.onInit();
  }

  @override
  void onClose() {
    controllerDispose();
    super.onClose();
  }
}
