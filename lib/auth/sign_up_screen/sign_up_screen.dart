import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinnierenee12/const/app_color.dart';
import 'package:tinnierenee12/const/app_const.dart';
import 'package:tinnierenee12/const/assets_icons_path.dart';
import 'package:tinnierenee12/routes/app_routes.dart';
import 'package:tinnierenee12/screen/auth/sign_up_screen/controller/signup_controller.dart';
import 'package:tinnierenee12/screen/role_selection_screen/role_selection_screen.dart';
import 'package:tinnierenee12/utils/app_size.dart';
import 'package:tinnierenee12/widget/app_button/app_button.dart';
import 'package:tinnierenee12/widget/app_image/app_image.dart';
import 'package:tinnierenee12/widget/app_input/app_input_widget_two.dart';
import 'package:tinnierenee12/widget/app_log/gap.dart';
import 'package:tinnierenee12/widget/app_text/app_text.dart';
import 'package:tinnierenee12/widget/appbar/custom_app_bar_auth.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarAuth(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GetBuilder<SignUpController>(
              init: SignUpController(),
              builder: (controlller) {
                return Padding(
                  padding: EdgeInsets.all(AppSize.width(value: 12)),

                  child: Column(
                    spacing: AppSize.size.height * 0.015,
                    children: [
                      Center(
                        child: AppImage(
                          path: AssetsPath.appLogo,
                          width: AppSize.size.width * 0.65,
                          // height: AppSize.size.width * 0.22,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Gap(height: AppSize.size.height * 0.009),
                      AppText(
                        data: "Create Your Account",
                        fontSize: AppSize.width(value: 18),
                        fontWeight: FontWeight.w600,
                        color: AppColor.white,
                      ),
                      AppText(
                        data: "Let's dive in into your occount",
                        fontSize: AppSize.width(value: 14),
                        fontWeight: FontWeight.w400,
                        color: AppColor.white,
                      ),
                      AppInputWidgetTwo(
                        borderRadius: AppSize.width(value: 8),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: AppSize.width(value: 20),
                        ),
                        hintText: "First Name",
                        fillColor: AppColor.purple,
                      ),
                      AppInputWidgetTwo(
                        isEmail: true,
                        borderRadius: AppSize.width(value: 8),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: AppSize.width(value: 20),
                        ),
                        hintText: "example@gmail.com",
                        fillColor: AppColor.purple,
                      ),
                      if (roll == "client")
                        AppInputWidgetTwo(
                          keyboardType: TextInputType.number,
                          borderRadius: AppSize.width(value: 8),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: AppSize.width(value: 20),
                          ),
                          hintText: "Phone Number",
                          fillColor: AppColor.purple,
                        ),

                      AppInputWidgetTwo(
                        borderRadius: AppSize.width(value: 8),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: AppSize.width(value: 20),
                        ),
                        isPassWord: true,
                        hintText: "Password",
                        fillColor: AppColor.purple,
                      ),
                      AppInputWidgetTwo(
                        borderRadius: AppSize.width(value: 8),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: AppSize.width(value: 20),
                        ),
                        isPassWord: true,
                        hintText: "Confirm Password",
                        fillColor: AppColor.purple,
                      ),

                      Gap(height: AppSize.width(value: 12)),
                      AppButton(
                        width: double.infinity,
                        onTap: () {
                          Get.toNamed(AppRoutes.instance.verifyOtpScreen);
                        },
                        title: "Sign Up",
                        titleSize: AppSize.width(value: 18),
                      ),
                      Obx(
                        () => Row(
                          children: [
                            Checkbox(
                              activeColor: AppColor.white,
                              checkColor: AppColor.black,
                              value: controlller.isChecked.value,
                              onChanged: (bool? value) {
                                controlller.toggleCheckbox(value ?? false);
                              },
                            ),
                            Flexible(
                              child: AppText(
                                data:
                                    "I agree to the Terms & Conditions and Privacy Policy",
                                fontSize: AppSize.width(value: 16),
                                fontWeight: FontWeight.w500,
                                color: AppColor.white,
                                textAlign: TextAlign
                                    .start, // Align the text to the start
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSize.width(value: 12)),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.instance.termsCondiScreen);
                },
                child: Text(
                  "Terms & Conditions",
                  style: TextStyle(
                    fontFamily: AppConst.fontFamily1,
                    fontSize: AppSize.width(value: 12),
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                    color: AppColor.white,
                    decorationColor: AppColor.white, // Underlines the text
                    // You can specify style of the underline if needed
                  ),
                ),
              ),
              Gap(width: AppSize.width(value: 20)),
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.instance.privicyScreen);
                },
                child: Text(
                  "Privacy Policy",
                  style: TextStyle(
                    fontFamily: AppConst.fontFamily1,
                    fontSize: AppSize.width(value: 12),
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                    color: AppColor.white,
                    decorationColor: AppColor.white, // Underlines the text
                    // You can specify style of the underline if needed
                  ),
                ),
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    data: "Already have an account?",
                    fontSize: AppSize.width(value: 12),
                    fontWeight: FontWeight.w700,
                    color: AppColor.white,
                  ),
                  Gap(height: AppSize.width(value: 8)),
                  InkWell(
                    onTap: () {
                      Get.offNamed(AppRoutes.instance.signInScreen);
                    },
                    child: AppText(
                      data: "Sign In",
                      fontSize: AppSize.width(value: 22),
                      fontWeight: FontWeight.w700,
                      color: AppColor.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
