import 'package:el_mago/const/role.dart';
import 'package:el_mago/models/user_model/user_model.dart';
import 'package:el_mago/routes/app_routes.dart';
import 'package:el_mago/services/repository/auth_repository.dart';
import 'package:el_mago/services/repository/profile_repository.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninController extends GetxController {
  //TextEditingController
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //all repository
  AuthRepository authRepository = AuthRepository.instance;
  ProfileRepository profileRepository = ProfileRepository.instance;

  ///Model variables
  Rxn<UserModelData> profileData = Rxn<UserModelData>();

  //Loading state
  RxBool loading = false.obs;

  //get profile

  Future<void> fetchProfileData() async {
    try {
      var response = await profileRepository.getProfileData();
      if (response != null) {
        profileData.value = response;
        AppPrint.apiResponse(response);
      }
      AppPrint.apiResponse(profileData.value?.image);
    } catch (e) {
      AppPrint.appError(e, title: "fetchProfileData");
    }
  }

  //Signin function
  Future<void> signin() async {
    try {
      bool valid = validation();
      if (!valid) return;

      loading.value = true;
      var response = await authRepository.login(
        email: emailController.text,
        password: passwordController.text,
      );
      if (response) {
        await fetchProfileData();

        if (profileData.value != null) {
          if (profileData.value?.role == Role.RETAILER.name) {
            Get.offAllNamed(AppRoutes.instance.retailerNavigationScreen);
          }
          if (profileData.value?.role == Role.SALES.name) {
            Get.offAllNamed(AppRoutes.instance.salesNavigationScreen);
          }
        } else {
          Get.snackbar("Error", "Profile data is empty");
        }

        Get.snackbar("Success", "You have successfully logged in!");
      } else {
        loading.value = false;
      }
    } catch (e) {
      AppPrint.appError(e, title: "signin");
    } finally {
      loading.value = false;
    }
  }

  //valisation
  bool validation() {
    if (emailController.text.isEmpty) {
      Get.snackbar("Error", "Email is empty");
      return false;
    }
    if (passwordController.text.isEmpty) {
      Get.snackbar("Error", "Password is empty");
      return false;
    }
    return true;
  }
}
