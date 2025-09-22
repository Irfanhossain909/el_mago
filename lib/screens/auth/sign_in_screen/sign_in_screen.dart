import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/const/assets_icons_path.dart';
import 'package:el_mago/routes/app_routes.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_image/app_image.dart';
import 'package:el_mago/widgets/app_input/app_input_widget_two.dart';
import 'package:el_mago/widgets/app_log/gap.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   leading: Padding(
      //     padding: EdgeInsets.all(18),
      //     child: AppImage(
      //       width: AppSize.width(value: 18),
      //       height: AppSize.width(value: 18),
      //       path: AssetsPath.arrowBack,
      //       iconColor: AppColor.white,
      //     ),
      //   ),
      // ),
      body: SafeArea(
        child: Padding(
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

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSize.size.width * 0.2,
                ),
                child: AppText(
                  height: 1.4,
                  textAlign: TextAlign.center,
                  data: "Please enter your email and password to continue",
                  fontSize: AppSize.width(value: 14),
                  fontWeight: FontWeight.w400,
                  color: AppColor.black,
                ),
              ),
              AppInputWidgetTwo(
                borderRadius: AppSize.width(value: 8),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppSize.width(value: 20),
                ),
                hintText: "example@gmail.com",
              ),

              AppInputWidgetTwo(
                borderRadius: AppSize.width(value: 8),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppSize.width(value: 20),
                ),
                isPassWord: true,
                hintText: "Password",
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.instance.forgetPasswordScreen);
                  },
                  child: AppText(
                    data: "Forgot Password",
                    fontSize: AppSize.width(value: 16),
                    fontWeight: FontWeight.w700,
                    color: AppColor.blue,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // if (roll == "employee") {
                  //   Get.toNamed(AppRoutes.instance.navigationScreen);
                  // } else {
                  //   Get.toNamed(AppRoutes.instance.navigationForClientScreen);
                  // }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.blue,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    data: "Don’t Have an Account?",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  Gap(width: AppSize.width(value: 4)),
                  InkWell(
                    onTap: () {
                      Get.offNamed(AppRoutes.instance.signupScreen);
                    },
                    child: AppText(
                      data: "Sign Up",
                      fontSize: AppSize.width(value: 18),
                      color: AppColor.blue,
                      fontWeight: FontWeight.w700,
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
