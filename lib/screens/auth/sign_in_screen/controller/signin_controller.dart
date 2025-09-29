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
  final ProfileRepository profileRepository = Get.find<ProfileRepository>();


  ///Model variables
  Rxn<UserModelData> profileData = Rxn<UserModelData>();

  //Loading state
  RxBool loading = false.obs;



  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Validate Email
  String? validateEmail(String? value) {
    bool emailValid =
    RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(value ?? "");
    if (value == null || value.isEmpty) {
      return "Enter Email";
    } else if (!emailValid) {
      return "Enter a valid Email";
    }
    return null;
  }

  // Validate Password
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Password";
    } else if (value.length < 6) {
      return "Password length should be more than 6 characters";
    }
    return null;
  }



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
    if (formKey.currentState!.validate()) {
      try {
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
      }

      finally {
        loading.value = false;
      }
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
