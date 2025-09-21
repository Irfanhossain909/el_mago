import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinnierenee12/widget/app_log/app_print.dart';

class VerifyOtpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController otpTextEditingController = TextEditingController();
  late String email;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is Map<String, dynamic>) {
      final args = Get.arguments as Map<String, dynamic>;
      email = args['email'] ?? '';
    } else {
      email = '';
    }
  }

  /// Resend the OTP code
  void resendCode() async {
    try {
      bool isSuccess = true; // Assume success for now
      if (isSuccess) {
        // No timer logic
      }
    } catch (e) {
      AppPrint.appError(e, title: "resendCode");
    }
  }
}
