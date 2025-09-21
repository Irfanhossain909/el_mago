import 'package:flutter/material.dart';
import 'package:tinnierenee12/const/app_color.dart';
import 'package:tinnierenee12/const/assets_icons_path.dart';
import 'package:tinnierenee12/utils/app_size.dart';
import 'package:tinnierenee12/widget/app_button/app_button.dart';
import 'package:tinnierenee12/widget/app_image/app_image.dart';
import 'package:tinnierenee12/widget/app_input/app_input_widget_two.dart';
import 'package:tinnierenee12/widget/app_log/gap.dart';
import 'package:tinnierenee12/widget/app_text/app_text.dart';

class CreatePasswordScreen extends StatelessWidget {
  const CreatePasswordScreen({super.key});

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
      body: Column(
        spacing: AppSize.size.height * 0.02,
        children: [
          AppImage(
            width: AppSize.width(value: 200),
            height: AppSize.width(value: 200),
            path: AssetsPath.authImg,
          ),

          AppText(
            data: "Set Your New Password",
            fontSize: AppSize.width(value: 22),
            fontWeight: FontWeight.w700,
            color: AppColor.white,
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSize.width(value: 30)),
            child: AppText(
              data:
                  "Create a new password for your account. Make sure it’s strong and secure.",
              textAlign: TextAlign.center,
              fontSize: AppSize.width(value: 16),
              fontWeight: FontWeight.w400,
              color: AppColor.white,
            ),
          ),

          Padding(
            padding: EdgeInsets.all(AppSize.width(value: 12)),

            child: Column(
              spacing: AppSize.size.height * 0.01,
              children: [
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
                  onTap: () {
                    // Get.toNamed(AppRoutes.instance.verifyOtpScreen);
                  },
                  title: "Save New Password",
                  titleSize: AppSize.width(value: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
