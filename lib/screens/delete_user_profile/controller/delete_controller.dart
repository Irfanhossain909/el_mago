import 'package:el_mago/routes/app_routes.dart';
import 'package:el_mago/services/api/get_storage_services.dart';
import 'package:el_mago/services/repository/common_repository.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteController extends GetxController {
  CommonRepository commonRepository = CommonRepository();
  TextEditingController password = TextEditingController();
  GetStorageServices getStorageServices = GetStorageServices.instance;

  // Loading state
  RxBool isLoading = false.obs;

  bool isValid() {
    if (password.text.isEmpty) {
      Get.snackbar("Error", "Password field is empty");
      return false;
    }
    return true;
  }

  Future<void> deleteUser() async {
    try {
      if (!isValid()) return;

      // Set loading state
      isLoading.value = true;

      final response = await commonRepository.deleteAccount(
        password: password.text,
      );
      if (response) {
        await getStorageServices.storageClear();
        Get.offAllNamed(AppRoutes.instance.signinScreen);
      }
    } catch (e) {
      AppPrint.appError(e, title: "DeleteController");
    } finally {
      // Reset loading state
      isLoading.value = false;
    }
  }
}
