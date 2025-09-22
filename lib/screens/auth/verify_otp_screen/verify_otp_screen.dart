import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/screens/auth/verify_otp_screen/controller/verify_otp_controller.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_button/app_button.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(18),
          child: Icon(Icons.arrow_back_ios, color: AppColor.black, size: 18),
        ),
      ),
      body: GetBuilder<VerifyOtpController>(
        init: VerifyOtpController(),
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

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSize.width(value: 30),
                  ),
                  child: AppText(
                    data:
                        "We’ve sent a verification code to your email/phone. Enter the code below to continue and secure your account.",
                    textAlign: TextAlign.center,
                    fontSize: AppSize.width(value: 16),
                    fontWeight: FontWeight.w400,
                    color: AppColor.black,
                  ),
                ),
                AppText(
                  data: "We've Sent a Code to exa...@email.com",
                  fontSize: AppSize.width(value: 16),
                  fontWeight: FontWeight.w700,
                  color: AppColor.black,
                ),

                Form(
                  key: controller.formKey,
                  child: PinCodeTextField(
                    length: 6,
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
                      // Optionally handle completion
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      data: 'If you didn’t receive a code. ',
                      fontSize: AppSize.width(value: 16),
                      color: AppColor.black,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.resendCode();
                      },
                      child: Text(
                        'Resend',
                        style: TextStyle(
                          fontSize: AppSize.width(value: 14),
                          fontWeight: FontWeight.w700,
                          color: AppColor.blue,
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSize.width(value: 16),
                  ),
                  child: AppButton(
                    onTap: () {
                      // Get.toNamed(AppRoutes.instance.locationScreen);
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
