import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinnierenee12/const/app_color.dart';
import 'package:tinnierenee12/const/app_const.dart';
import 'package:tinnierenee12/const/assets_icons_path.dart';
import 'package:tinnierenee12/routes/app_routes.dart';
import 'package:tinnierenee12/screen/role_selection_screen/role_selection_screen.dart';
import 'package:tinnierenee12/utils/app_size.dart';
import 'package:tinnierenee12/widget/app_image/app_image.dart';
import 'package:tinnierenee12/widget/app_input/app_input_widget_two.dart';
import 'package:tinnierenee12/widget/app_log/gap.dart';
import 'package:tinnierenee12/widget/app_text/app_text.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(18),
          child: AppImage(
            width: AppSize.width(value: 18),
            height: AppSize.width(value: 18),
            path: AssetsPath.arrowBack,
            iconColor: AppColor.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSize.width(value: 12)),

        child: Column(
          spacing: AppSize.size.height * 0.01,
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
              data: "Let's Get Started!",
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
              hintText: "example@gmail.com",
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
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.instance.forgetPassScreen);
                },
                child: AppText(
                  data: "Forgot Password",
                  fontSize: AppSize.width(value: 14),
                  fontWeight: FontWeight.w700,
                  color: AppColor.white,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (roll == "employee") {
                  Get.toNamed(AppRoutes.instance.navigationScreen);
                } else {
                  Get.toNamed(AppRoutes.instance.navigationForClientScreen);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.gold,
                  borderRadius: BorderRadius.circular(12),
                ),
                width: AppSize.width(value: double.infinity),
                height: AppSize.size.height * 0.06,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppText(
                      data: "Sign In",
                      fontSize: AppSize.width(value: 18),
                      fontWeight: FontWeight.w600,
                      color: AppColor.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_right_alt_outlined,
                        size: AppSize.width(value: 28),
                        color: AppColor.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gap(height: AppSize.size.height * 0.005),
            Container(
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(12),
              ),
              width: AppSize.width(value: double.infinity),
              height: AppSize.size.height * 0.06,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppImage(
                    path: AssetsPath.google,
                    width: AppSize.width(value: 18),
                  ),
                  AppText(
                    data: "Continue with Google",
                    fontSize: AppSize.width(value: 16),
                    fontWeight: FontWeight.w600,
                    color: AppColor.black,
                  ),
                  SizedBox(),
                ],
              ),
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
                    decorationColor: AppColor.white,
                    color: AppColor.white, // Underlines the text
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
                    decorationColor: AppColor.white,
                    color: AppColor.white, // Underlines the text
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
                    data: "Don’t Have an Account?",
                    fontSize: AppSize.width(value: 12),
                    fontWeight: FontWeight.w700,
                    color: AppColor.white,
                  ),
                  InkWell(
                    onTap: () {
                      Get.offNamed(AppRoutes.instance.signUpScreen);
                    },
                    child: AppText(
                      data: "Sign Up",
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
