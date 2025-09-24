import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/screens/auth/forget_pass_screen/controller/forget_password_controller.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_button/app_button.dart';
import 'package:el_mago/widgets/app_input/app_input_widget_two.dart';
import 'package:el_mago/widgets/app_loading/app_loading.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPassScreen extends StatelessWidget {
  const ForgetPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordController>(
      init: ForgetPasswordController(),
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              // Center the entire column within the body
              child: Padding(
                padding: EdgeInsets.all(AppSize.width(value: 12)),
                child: Stack(
                  children: [
                    Column(
                      spacing: AppSize.size.height * 0.025,
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Center items vertically
                      crossAxisAlignment: CrossAxisAlignment
                          .center, // Center items horizontally
                      children: [
                        AppText(
                          data: "Forgot Your Password?",
                          fontSize: AppSize.width(value: 18),
                          fontWeight: FontWeight.w700,
                          color: AppColor.black,
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSize.width(value: 20),
                          ),
                          child: AppText(
                            data:
                                "Enter your email below to reset your password",
                            textAlign: TextAlign.center,
                            fontSize: AppSize.width(value: 16),
                            fontWeight: FontWeight.w400,
                            color: AppColor.black,
                          ),
                        ),

                        AppInputWidgetTwo(
                          controller: controller.emailController,
                          borderRadius: AppSize.width(value: 8),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: AppSize.width(value: 20),
                          ),
                          hintText: "example@gmail.com",
                        ),

                        AppButton(
                          onTap: () {
                            controller.forgetPassEmailSend();
                          },
                          title: "Get Verification Code",
                        ),
                      ],
                    ),

                    Obx(() {
                      if (controller.isLoading.value) {
                        return Positioned(
                          top: 0,
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: AppLoading(),
                        );
                      }
                      return SizedBox.shrink();
                    }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
