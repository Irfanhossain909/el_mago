import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinnierenee12/const/app_color.dart';
import 'package:tinnierenee12/const/assets_icons_path.dart';
import 'package:tinnierenee12/routes/app_routes.dart';
import 'package:tinnierenee12/utils/app_size.dart';
import 'package:tinnierenee12/widget/app_button/app_button.dart';
import 'package:tinnierenee12/widget/app_image/app_image.dart';
import 'package:tinnierenee12/widget/app_input/app_input_widget_two.dart';
import 'package:tinnierenee12/widget/app_log/gap.dart';
import 'package:tinnierenee12/widget/app_text/app_text.dart';

class ForgetPassScreen extends StatelessWidget {
  const ForgetPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SafeArea(
        child: Column(
          children: [
            AppImage(
              width: AppSize.width(value: 200),
              height: AppSize.width(value: 200),
              path: AssetsPath.authImg,
            ),
            Gap(height: AppSize.width(value: 30)),
            Padding(
              padding: EdgeInsets.all(AppSize.width(value: 12)),

              child: Column(
                spacing: AppSize.size.height * 0.03,
                children: [
                  AppText(
                    data: "Forgot Your Password?",
                    fontSize: AppSize.width(value: 18),
                    fontWeight: FontWeight.w700,
                    color: AppColor.white,
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSize.width(value: 20),
                    ),
                    child: AppText(
                      data:
                          "No worries! Enter the email address associated with your account, and we’ll send you instructions to reset your password.",
                      textAlign: TextAlign.center,
                      fontSize: AppSize.width(value: 16),
                      fontWeight: FontWeight.w400,
                      color: AppColor.white,
                    ),
                  ),
                  AppInputWidgetTwo(
                    borderRadius: AppSize.width(value: 8),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AppSize.width(value: 20),
                    ),
                    hintText: "example@gmail.com",
                    fillColor: AppColor.purple,
                  ),
                  AppButton(
                    onTap: () {
                      Get.toNamed(AppRoutes.instance.verifyOtpScreen);
                    },
                    title: "Get Verification Code",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
