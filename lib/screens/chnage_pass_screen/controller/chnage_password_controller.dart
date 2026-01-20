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
  //form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //loading indicator
  RxBool isLoading = false.obs;


  // Validate Old Password
  String? validateOldPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter your old password";
    } else if (value.length < 8) {
      return "Old password should be at least 8 characters long";
    }
    return null;
  }

// Validate New Password
  String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter a new password";
    } else if (value.length < 8) {
      return "New password should be at least 8 characters long";
    }
    return null;
  }

// Validate Confirm Password
  String? validateConfirmPassword(String? value, String newPassword) {
    if (value == null || value.isEmpty) {
      return "Confirm your new password";
    } else if (value != newPassword) {
      return "Passwords do not match";
    }
    return null;
  }


  // change password function
  Future<void> changePassword() async {
    if (formKey.currentState!.validate()) {
      try {
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
