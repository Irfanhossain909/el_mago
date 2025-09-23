import 'dart:async';

import 'package:el_mago/const/role.dart';
import 'package:el_mago/services/api/get_storage_services.dart';
import 'package:el_mago/services/repository/auth_repository.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyOtpController extends GetxController {
  final RxInt _seconds = 0.obs;
  RxInt get seconds => _seconds;
  Timer? _timer;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AuthRepository authRepository = AuthRepository.instance;
  GetStorageServices getStorageServices = GetStorageServices.instance;
  TextEditingController otpTextEditingController = TextEditingController();
  late String email;

  //loading function
  RxBool isLoading = false.obs;

  //validate function
  bool validate() {
    if (otpTextEditingController.text.isNotEmpty ||
        otpTextEditingController.text.length == 4) {
      return false;
    }

    return true;
  }

  //resend otp function
  Future<void> resendOtp() async {
    try {
      var response = await authRepository.forgetEmailSend(email: email);
      if (response) {
        reCallStatTimer();
        Get.snackbar(
          "Success",
          "OTP has been successfully sent to your email.",
        );
      } else {
        Get.snackbar("Failed", "Failed to send OTP. Please try again later.");
      }
    } catch (e) {
      AppPrint.appError(e, title: "resendOtp");
    }
  }

  //verify otp function
  Future<void> emailVerify() async {
    try {
      bool valid = validate();
      if (valid) return;

      isLoading.value = true;
      var response = await authRepository.emailVerify(
        email: email,
        otp: int.parse(otpTextEditingController.text),
      );
      if (response) {
        String role = getStorageServices.getUserRole();
        if (role == Role.RETAILER) {
          Get.snackbar("Success", "You are a retailer");
        }
        if (role == Role.SALES) {
          Get.snackbar("Success", "You are a sales");
        }
        Get.snackbar("Successsfull !!!", "");
      } else {
        isLoading.value = false;
        AppPrint.appPrint("forget password otp verify response false");
      }
    } catch (e) {
      AppPrint.appError(
        e.toString(),
        title: "Forget Password OTP verify controller",
      );
    } finally {
      isLoading.value = false;
    }
  }

  //formet timer
  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return minutes > 0
        ? '$minutes:${remainingSeconds.toString().padLeft(2, '0')}'
        : '$remainingSeconds';
  }

  //start timer
  void startTimer() async {
    try {
      _seconds.value = 180;
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        _seconds.value = _seconds.value - 1;
        if (_seconds.value <= 0) {
          stopTimer();
        }
      });
    } catch (e) {
      AppPrint.appLog(e.toString());
    }
  }

  //reCall stat timer
  reCallStatTimer() {
    if (seconds.value == 0) {
      startTimer();
    }
  }

  //stop timer
  void stopTimer() {
    try {
      _seconds.value = 0;
      _timer?.cancel();
      _timer = null;
    } catch (e) {
      AppPrint.appLog(e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments ?? '';
    startTimer();
  }

  @override
  void onClose() {
    stopTimer();
    super.onClose();
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
