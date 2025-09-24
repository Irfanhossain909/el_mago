import 'package:el_mago/routes/app_routes.dart';
import 'package:el_mago/services/api/get_storage_services.dart';
import 'package:el_mago/widgets/app_log/error_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  GetStorageServices storageServices = GetStorageServices.instance;
  RxDouble animation = 0.0.obs;
  RxDouble animation2 = 0.0.obs;
  // Future<void> fetchProfileData() async {
  //   try {
  //     var response = await profileRepository.getProfileData();
  //     if (response != null) {
  //       profileData.value = response;
  //     }
  //     AppPrint.apiResponse(profileData.value?.image);
  //   } catch (e) {
  //     AppPrint.appError(e, title: "fetchProfileData");
  //   }
  // }

  Future<void> onInitialDataLoadScreen() async {
    try {
      Future.delayed(Durations.medium1, () {
        animation.value = 1.0;
        animation2.value = 1.0;
      });

      Future.delayed(Duration(seconds: 3), () async {
        Get.offAllNamed(AppRoutes.instance.signinScreen);
      });

      // final String token = storageServices.getToken();
      // if (token.isNotEmpty) {
      //   await fetchProfileData();
      //   if (profileData.value?.isFullfilled == true) {
      //     AppPrint.apiResponse(profileData.value?.isFullfilled);
      //     Get.offAllNamed(AppRoutes.instance.navigationScreen);
      //   } else {
      //     Get.offAllNamed(AppRoutes.instance.selectBirthScreen);
      //   }
      // } else {
      //   Get.offAllNamed(AppRoutes.instance.onBoardingScreen);
      // }
      // Get.delete<SplashController>();
      // }
      // );
    } catch (e) {
      errorLog("onInitialDataLoadScreen", e);
    }
  }

  @override
  void onInit() {
    onInitialDataLoadScreen();
    super.onInit();
  }
}
