import 'package:el_mago/routes/app_routes.dart';
import 'package:el_mago/services/repository/auth_repository.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  //All Repositories
  AuthRepository authRepository = AuthRepository.instance;

  //TextEditingController
  TextEditingController emailController = TextEditingController();

  //loading indicator
  RxBool isLoading = false.obs;

  //validation
  bool validate() {
    if (emailController.text.isEmpty) {
      Get.snackbar("Error", "Please enter your old password");
      return false;
    }
    return true;
  }

  // change password function
  Future<void> forgetPassEmailSend() async {
    try {
      if (!validate()) return;
      isLoading.value = true;
      var response = await authRepository.forgetEmailSend(
        email: emailController.text,
      );

      if (response) {
        Get.snackbar("Success", "Otp send your email successfully");
        Get.toNamed(
          AppRoutes.instance.forgetPassOtpVerifyScreen,
          arguments: emailController.text,
        );
      } else {
        isLoading.value = false;
        Get.snackbar("Error", "Password change failed");
      }
    } catch (e) {
      AppPrint.appError(e, title: "Forget Password");
    } finally {
      isLoading.value = false;
    }
  }

  ///dispose
  void controllerDispose() {
    emailController.dispose();
  }

  //controller initialize
  void controllerInisialize() {
    emailController = TextEditingController();
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
