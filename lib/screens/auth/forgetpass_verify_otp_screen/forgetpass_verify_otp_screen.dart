import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/screens/auth/forgetpass_verify_otp_screen/controller/forgetpass_verify_otp_controller.dart';
import 'package:el_mago/screens/auth/verify_otp_screen/controller/verify_otp_controller.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_button/app_button.dart';
import 'package:el_mago/widgets/app_loading/app_loading.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgetPassVerifyOtpScreen extends StatelessWidget {
  const ForgetPassVerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(18),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios, color: AppColor.black, size: 18),
          ),
        ),
      ),
      body: GetBuilder<ForgetPassVerifyOtpController>(
        init: ForgetPassVerifyOtpController(),
        builder: (controller) {
          return Center(
            child: Column(
              spacing: AppSize.size.height * 0.02,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppText(
                  data: "Verification Code",
                  fontSize: AppSize.width(value: 28),
                  fontWeight: FontWeight.w700,
                  color: AppColor.black,
                ),

                Obx(() {
                  return Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSize.width(value: 30),
                        ),
                        child: AppText(
                          data:
                              "We’ve sent a verification code to your email Enter the code below to continue and secure your account.",
                          textAlign: TextAlign.center,
                          fontSize: AppSize.width(value: 16),
                          fontWeight: FontWeight.w400,
                          color: AppColor.black,
                        ),
                      ),
                      controller.isLoading.value ? AppLoading() : SizedBox(),
                    ],
                  );
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      data: "We've Sent a Code to ",
                      fontSize: AppSize.width(value: 16),
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                    ),
                    AppText(
                      data: controller.email,
                      fontSize: AppSize.width(value: 16),
                      fontWeight: FontWeight.w700,
                      color: AppColor.black,
                    ),
                  ],
                ),

                Form(
                  key: controller.formKey,
                  child: PinCodeTextField(
                    length: 4,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,

                      borderRadius: BorderRadius.circular(8),
                      fieldHeight: 46,
                      fieldWidth: 42,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,

                    controller: controller.otpTextEditingController,
                    appContext: context,
                    onCompleted: (code) {
                      controller.otpTextEditingController.text = code;
                      AppPrint.appLog(code);
                    },
                  ),
                ),
                Obx(() {
                  if (controller.seconds.value == 0) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          data: "The code has expired",
                          color: AppColor.black,
                        ),
                        TextButton(
                          onPressed: () {
                            controller.resendOtp();
                          },
                          child: AppText(
                            data: "Resend",
                            color: AppColor.blue,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          data: "This code will expire in ",
                          color: AppColor.black,
                          textAlign: TextAlign.center,
                        ),
                        AppText(
                          data: controller.formatTime(controller.seconds.value),
                          color: AppColor.blue,
                          fontWeight: FontWeight.w700,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  }
                }),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSize.width(value: 16),
                  ),
                  child: AppButton(
                    onTap: () {
                      controller.emailVerify();
                    },
                    title: "Verify and Continue",
                    titleSize: AppSize.width(value: 18),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
