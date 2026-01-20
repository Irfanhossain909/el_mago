import 'package:el_mago/const/role.dart';
import 'package:el_mago/models/user_model/user_model.dart';
import 'package:el_mago/routes/app_routes.dart';
import 'package:el_mago/services/api/get_storage_services.dart';
import 'package:el_mago/services/repository/profile_repository.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:el_mago/widgets/app_log/error_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  GetStorageServices storageServices = GetStorageServices.instance;
  final ProfileRepository profileRepository = Get.find<ProfileRepository>();

  RxDouble animation = 0.0.obs;
  RxDouble animation2 = 0.0.obs;

  ///Model variables
  Rxn<UserModelData> profileData = Rxn<UserModelData>();

  //get profile data - same logic as signin controller
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

  Future<void> onInitialDataLoadScreen() async {
    try {
      Future.delayed(Durations.medium1, () {
        animation.value = 1.0;
        animation2.value = 1.0;
      });

      Future.delayed(Duration(seconds: 3), () async {
        // Check if user has stored token
        final String token = storageServices.getToken();

        if (token.isNotEmpty) {
          // User has token, try to fetch profile and auto-login
          await fetchProfileData();

          if (profileData.value != null) {
            // Navigate based on user role, same logic as signin controller
            if (profileData.value?.role == Role.RETAILER.name) {
              Get.offAllNamed(AppRoutes.instance.retailerNavigationScreen);
            } else if (profileData.value?.role == Role.SALES.name) {
              Get.offAllNamed(AppRoutes.instance.salesNavigationScreen);
            } else {
              // Unknown role, go to signin
              Get.offAllNamed(AppRoutes.instance.signinScreen);
            }
          } else {
            // Profile data is empty, token might be invalid
            AppPrint.apiResponse(
              "Profile data is empty, redirecting to signin",
            );
            Get.offAllNamed(AppRoutes.instance.signinScreen);
          }
        } else {
          // No token found, user needs to login
          Get.offAllNamed(AppRoutes.instance.signinScreen);
        }
      });
    } catch (e) {
      errorLog("onInitialDataLoadScreen", e);
      // On error, redirect to signin screen
      Get.offAllNamed(AppRoutes.instance.signinScreen);
    }
  }

  @override
  void onInit() {
    onInitialDataLoadScreen();
    super.onInit();
  }
}
